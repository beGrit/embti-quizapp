import 'dart:convert';

import 'package:emombti/config/assets.dart';
import 'package:emombti/domain/models/content/content.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/models/quiz/survey_models.dart';

class LocalStorageSqlite {
  Future<Database>? _database;
  String? _currentUserId;

  LocalStorageSqlite() {
    _database = _initDB();
  }

  Future<void> switchUser(String? userId) async {
    if (_currentUserId == userId) return;

    final db = await _database;
    await db?.close();

    _currentUserId = userId;
    _database = _initDB();
    await _database;
  }

  Future<Database> get database async {
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final dbName = _currentUserId != null
        ? 'emombti_quiz_$_currentUserId.db'
        : 'emombti_quiz.db';
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 9, // Increment version for schema change (removing userId)
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE survey_flows (
            id TEXT PRIMARY KEY,
            surveyId TEXT NOT NULL,
            status TEXT NOT NULL,
            startTime TEXT,
            endTime TEXT,
            totalQuestions INTEGER,
            questionOrder TEXT,   -- JSON List
            currentAnswers TEXT,  -- JSON Map
            synchronized INTEGER NOT NULL DEFAULT 0,
            deleted INTEGER NOT NULL DEFAULT 0
          )
        ''');
        await db.execute('''
          CREATE TABLE assessment_results (
            surveyFlowId TEXT PRIMARY KEY,
            timestamp TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE axis_scores (
            surveyFlowId TEXT NOT NULL,
            axis INTEGER NOT NULL,
            value REAL NOT NULL,
            PRIMARY KEY (surveyFlowId, axis),
            FOREIGN KEY (surveyFlowId) REFERENCES assessment_results (surveyFlowId) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 9) {
          // Simplest for dev: drop and recreate to remove userId if present
          await db.execute('DROP TABLE IF EXISTS axis_scores');
          await db.execute('DROP TABLE IF EXISTS assessment_results');
          await db.execute('DROP TABLE IF EXISTS survey_flows');

          await db.execute('''
            CREATE TABLE survey_flows (
              id TEXT PRIMARY KEY,
              surveyId TEXT NOT NULL,
              status TEXT NOT NULL,
              startTime TEXT,
              endTime TEXT,
              totalQuestions INTEGER,
              questionOrder TEXT,   -- JSON List
              currentAnswers TEXT,  -- JSON Map
              synchronized INTEGER NOT NULL DEFAULT 0,
              deleted INTEGER NOT NULL DEFAULT 0
            )
          ''');
          await db.execute('''
            CREATE TABLE assessment_results (
              surveyFlowId TEXT PRIMARY KEY,
              timestamp TEXT NOT NULL
            )
          ''');
          await db.execute('''
            CREATE TABLE axis_scores (
              surveyFlowId TEXT NOT NULL,
              axis INTEGER NOT NULL,
              value REAL NOT NULL,
              PRIMARY KEY (surveyFlowId, axis),
              FOREIGN KEY (surveyFlowId) REFERENCES assessment_results (surveyFlowId) ON DELETE CASCADE
            )
          ''');
        }
      },
    );
  }

  Future<void> saveFlow(SurveyFlow flow) async {
    final db = await database;
    await db.insert('survey_flows', {
      'id': flow.id,
      'surveyId': flow.surveyId,
      'status': flow.status.name,
      'startTime': flow.startTime?.toIso8601String(),
      'endTime': flow.endTime?.toIso8601String(),
      'totalQuestions': flow.totalQuestions,
      'questionOrder': jsonEncode(flow.questionOrder),
      'currentAnswers': jsonEncode(flow.currentAnswers),
      'synchronized': flow.synchronized ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  SurveyFlow _surveyFlowFromRow(Map<String, Object?> map) {
    return SurveyFlow(
      id: map['id'] as String,
      surveyId: map['surveyId'] as String,
      status: SurveyFlowStatus.values.firstWhere(
        (e) => e.name == map['status'],
      ),
      startTime: map['startTime'] != null
          ? DateTime.parse(map['startTime'] as String)
          : null,
      endTime: map['endTime'] != null
          ? DateTime.parse(map['endTime'] as String)
          : null,
      totalQuestions: map['totalQuestions'] as int,
      questionOrder: List<String>.from(
        jsonDecode(map['questionOrder'] as String),
      ),
      currentAnswers: Map<String, int>.from(
        jsonDecode(map['currentAnswers'] as String),
      ),
      synchronized: (map['synchronized'] as int) == 1,
    );
  }

  Future<SurveyFlow?> getFlow(String id) async {
    final db = await database;
    final maps = await db.query(
      'survey_flows',
      where: 'id = ? AND deleted = 0',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return _surveyFlowFromRow(maps.first);
  }

  Future<List<SurveyFlow>> getFlows({String? surveyId}) async {
    final db = await database;
    String whereClause = 'deleted = 0';
    List<Object?>? whereArgs;
    if (surveyId != null) {
      whereClause += ' AND surveyId = ?';
      whereArgs = [surveyId];
    }
    final maps = await db.query(
      'survey_flows',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'startTime DESC',
    );
    return maps.map(_surveyFlowFromRow).toList();
  }

  Future<void> deleteFlow(String id) async {
    final db = await database;
    await db.update(
      'survey_flows',
      {'deleted': 1, 'synchronized': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> saveResult(AssessmentResult result) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('assessment_results', {
        'surveyFlowId': result.surveyFlowId,
        'timestamp': result.timestamp.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      for (final score in result.scores) {
        await txn.insert('axis_scores', {
          'surveyFlowId': result.surveyFlowId,
          'axis': score.axis.index,
          'value': score.value,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> saveSubmission(AssessmentResult result) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('assessment_results', {
        'surveyFlowId': result.surveyFlowId,
        'timestamp': result.timestamp.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      for (final score in result.scores) {
        await txn.insert('axis_scores', {
          'surveyFlowId': result.surveyFlowId,
          'axis': score.axis.index,
          'value': score.value,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await txn.delete(
        'survey_flows',
        where: 'id = ?',
        whereArgs: [result.surveyFlowId],
      );
    });
  }

  Future<List<AssessmentResult>> getAllAssessmentResults() async {
    final db = await database;
    final resultsMaps = await db.query(
      'assessment_results',
      orderBy: 'timestamp DESC',
    );

    final List<AssessmentResult> results = [];
    for (final resMap in resultsMaps) {
      final surveyFlowId = resMap['surveyFlowId'] as String;
      final scoresMaps = await db.query(
        'axis_scores',
        where: 'surveyFlowId = ?',
        whereArgs: [surveyFlowId],
      );

      final scores = scoresMaps
          .map(
            (s) => AxisScore(
              axis: PersonalityAxis.values[s['axis'] as int],
              value: s['value'] as double,
            ),
          )
          .toList();

      results.add(
        AssessmentResult(
          surveyFlowId: surveyFlowId,
          timestamp: DateTime.parse(resMap['timestamp'] as String),
          scores: scores,
        ),
      );
    }
    return results;
  }

  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId) async {
    final db = await database;
    final maps = await db.query(
      'assessment_results',
      where: 'surveyFlowId = ?',
      whereArgs: [surveyFlowId],
    );
    if (maps.isEmpty) return null;
    final map = maps.first;

    final scoresMaps = await db.query(
      'axis_scores',
      where: 'surveyFlowId = ?',
      whereArgs: [surveyFlowId],
    );

    final scores = scoresMaps
        .map(
          (s) => AxisScore(
            axis: PersonalityAxis.values[s['axis'] as int],
            value: s['value'] as double,
          ),
        )
        .toList();

    return AssessmentResult(
      surveyFlowId: map['surveyFlowId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      scores: scores,
    );
  }

  Future<void> clearAssessmentHistory() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('axis_scores');
      await txn.delete('assessment_results');
    });
  }

  Future<List<Content>> getMockFeed() async {
    final articles = await getArticleContents();
    final videos = await getVideoContents();
    final knowledge = await getKnowledgeContents();
    final banners = await getBannerContents();
    final combined = [...articles, ...videos, ...knowledge, ...banners];
    combined.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return combined;
  }

  Future<List<ArticleContent>> getArticleContents() async {
    final json = await _loadStringAsset(AppAssets.articlesJson);
    return json.map<ArticleContent>((e) => ArticleContent.fromJson(e)).toList();
  }

  Future<ArticleContent?> getArticleContentById(String id) async {
    final articles = await getArticleContents();
    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoContent>> getVideoContents() async {
    final json = await _loadStringAsset(AppAssets.videosJson);
    return json.map<VideoContent>((e) => VideoContent.fromJson(e)).toList();
  }

  Future<List<KnowledgeContent>> getKnowledgeContents() async {
    final json = await _loadStringAsset(AppAssets.knowledgeJson);
    return json
        .map<KnowledgeContent>((e) => KnowledgeContent.fromJson(e))
        .toList();
  }

  Future<List<BannerContent>> getBannerContents() async {
    final json = await _loadStringAsset(AppAssets.bannersJson);
    return json.map<BannerContent>((e) => BannerContent.fromJson(e)).toList();
  }

  Future<List<AssessmentResult>> getAssessmentResults() async {
    final json = await _loadStringAsset(AppAssets.assessmentResultsJson);
    return json
        .map<AssessmentResult>((e) => AssessmentResult.fromJson(e))
        .toList();
  }

  Future<List<Map<String, dynamic>>> _loadStringAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }
}
