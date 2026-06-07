import 'dart:convert';

import 'package:emombti/config/assets.dart';
import 'package:emombti/data/services/persistence/local/local_storage.dart';
import 'package:emombti/domain/models/content/content.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/models/quiz/survey_models.dart';

class LocalStorageSqlite implements LocalStorage {
  late final Future<Database>? _database;

  LocalStorageSqlite() {
    _database = _initDB();
  }

  Future<Database> get database async {
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'emombti_quiz.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        // Survey (Questions, Flow, Result)
        await db.execute('''
          CREATE TABLE surveys (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            data_json TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE survey_flows (
            id TEXT PRIMARY KEY,
            surveyId TEXT NOT NULL,
            status TEXT NOT NULL,
            startTime TEXT,
            endTime TEXT,
            totalQuestions INTEGER,
            questionOrder TEXT,   -- 存储为 JSON List
            currentAnswers TEXT   -- 存储为 JSON Map
          )
        ''');
        await db.execute('''
          CREATE TABLE assessment_results (
            surveyFlowId TEXT PRIMARY KEY,
            scores TEXT,          -- 存储为 JSON List
            timestamp TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS survey_responses (
              surveyFlowId TEXT PRIMARY KEY,
              surveyId TEXT NOT NULL,
              answers_json TEXT NOT NULL,
              submitted_at TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  @override
  Future<Survey?> getSurvey(String id) async {
    final db = await database;
    final maps = await db.query('surveys', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Survey.fromJson(jsonDecode(maps.first['data_json'] as String));
  }

  @override
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
    );
  }

  @override
  Future<SurveyFlow?> getFlow(String id) async {
    final db = await database;
    final maps = await db.query(
      'survey_flows',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return _surveyFlowFromRow(maps.first);
  }

  @override
  Future<List<SurveyFlow>> getFlows({String? surveyId}) async {
    final db = await database;
    final maps = await db.query(
      'survey_flows',
      where: surveyId != null ? 'surveyId = ?' : null,
      whereArgs: surveyId != null ? [surveyId] : null,
      orderBy: 'startTime DESC',
    );
    return maps.map(_surveyFlowFromRow).toList();
  }

  @override
  Future<void> deleteFlow(String id) async {
    final db = await database;
    await db.delete('survey_flows', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> saveResult(AssessmentResult result) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('assessment_results', {
        'surveyFlowId': result.surveyFlowId,
        'scores': jsonEncode(result.scores.map((e) => e.toJson()).toList()),
        'timestamp': result.timestamp.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  @override
  Future<void> saveSubmission(AssessmentResult result) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('assessment_results', {
        'surveyFlowId': result.surveyFlowId,
        'scores': jsonEncode(result.scores.map((e) => e.toJson()).toList()),
        'timestamp': result.timestamp.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      await txn.delete(
        'survey_flows',
        where: 'id = ?',
        whereArgs: [result.surveyFlowId],
      );
    });
  }

  @override
  Future<List<AssessmentResult>> getAllAssessmentResults() async {
    final db = await database;
    final maps = await db.query(
      'assessment_results',
      orderBy: 'timestamp DESC',
    );
    return maps
        .map(
          (map) => AssessmentResult(
            surveyFlowId: map['surveyFlowId'] as String,
            timestamp: DateTime.parse(map['timestamp'] as String),
            scores: (jsonDecode(map['scores'] as String) as List)
                .map((e) => AxisScore.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId) async {
    final db = await database;
    final maps = await db.query(
      'assessment_results',
      where: 'surveyFlowId = ?',
      whereArgs: [surveyFlowId],
    );
    if (maps.isEmpty) return null;
    final map = maps.first;
    return AssessmentResult(
      surveyFlowId: map['surveyFlowId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      scores: (jsonDecode(map['scores'] as String) as List)
          .map((e) => AxisScore.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<void> clearAssessmentHistory() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('assessment_results');
    });
  }

  @override
  Future<List<Content>> getMockFeed() async {
    final articles = await getArticleContents();
    final videos = await getVideoContents();
    final knowledge = await getKnowledgeContents();
    final banners = await getBannerContents();
    final combined = [...articles, ...videos, ...knowledge, ...banners];
    combined.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return combined;
  }

  @override
  Future<List<ArticleContent>> getArticleContents() async {
    final json = await _loadStringAsset(AppAssets.articlesJson);
    return json.map<ArticleContent>((e) => ArticleContent.fromJson(e)).toList();
  }

  @override
  Future<ArticleContent?> getArticleContentById(String id) async {
    final articles = await getArticleContents();

    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<VideoContent>> getVideoContents() async {
    final json = await _loadStringAsset(AppAssets.videosJson);
    return json.map<VideoContent>((e) => VideoContent.fromJson(e)).toList();
  }

  @override
  Future<List<KnowledgeContent>> getKnowledgeContents() async {
    final json = await _loadStringAsset(AppAssets.knowledgeJson);
    return json
        .map<KnowledgeContent>((e) => KnowledgeContent.fromJson(e))
        .toList();
  }

  @override
  Future<List<BannerContent>> getBannerContents() async {
    final json = await _loadStringAsset(AppAssets.bannersJson);
    return json.map<BannerContent>((e) => BannerContent.fromJson(e)).toList();
  }

  @override
  Future<List<Survey>> getQuizzes() async {
    final json = await _loadStringAsset(AppAssets.quizzesJson);
    return json.map<Survey>((e) => Survey.fromJson(e)).toList();
  }

  @override
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
