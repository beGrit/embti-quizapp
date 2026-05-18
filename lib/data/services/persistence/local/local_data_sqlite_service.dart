import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/models/quiz/survey_models.dart';
import '../../../../domain/models/user/user.dart';

class LocalDataSqliteService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'emombti_quiz.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        // 1. Survey 静态数据表 (缓存从 JSON 加载的题目)
        await db.execute('''
          CREATE TABLE surveys (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            data_json TEXT NOT NULL
          )
        ''');

        // 2. SurveyFlow 进度表 (记录当前正在进行的测试)
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

        // 3. AssessmentResult 结果表 (存储已完成的报告)
        await db.execute('''
          CREATE TABLE assessment_results (
            surveyFlowId TEXT PRIMARY KEY,
            scores TEXT,          -- 存储为 JSON List
            timestamp TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE survey_responses (
            surveyFlowId TEXT PRIMARY KEY,
            surveyId TEXT NOT NULL,
            answers_json TEXT NOT NULL,
            submitted_at TEXT NOT NULL
          )
        ''');

        // 5. User tables
        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            data_json TEXT NOT NULL
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
        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS users (
              id TEXT PRIMARY KEY,
              data_json TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  // --- User Logic ---

  Future<User?> getUserById(String id) async {
    final db = await database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return User.fromJson(jsonDecode(maps.first['data_json'] as String));
  }

  Future<void> saveUser(User user) async {
    final db = await database;
    await db.insert('users', {
      'id': user.id,
      'data_json': jsonEncode(user.toJson()),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // --- Survey 缓存逻辑 ---

  Future<void> cacheSurveys(List<Survey> surveys) async {
    final db = await database;
    final batch = db.batch();
    for (var survey in surveys) {
      batch.insert('surveys', {
        'id': survey.id,
        'title': survey.title,
        'data_json': jsonEncode(survey.toJson()),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<Survey?> getSurvey(String id) async {
    final db = await database;
    final maps = await db.query('surveys', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Survey.fromJson(jsonDecode(maps.first['data_json'] as String));
  }

  // --- SurveyFlow (进度) 逻辑 ---

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

  Future<void> deleteFlow(String id) async {
    final db = await database;
    await db.delete('survey_flows', where: 'id = ?', whereArgs: [id]);
  }

  // --- AssessmentResult (结果) 逻辑 ---

  Future<void> saveResult(AssessmentResult result) async {
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

  /// Persists [response] and [result] and clears the active [SurveyFlow] row.
  Future<void> saveSubmission(
    SurveyResponse response,
    AssessmentResult result,
  ) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('survey_responses', {
        'surveyFlowId': response.surveyFlowId,
        'surveyId': response.surveyId,
        'answers_json': jsonEncode(response.answers),
        'submitted_at': result.timestamp.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
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

  Future<SurveyResponse?> getSurveyResponse(String surveyFlowId) async {
    final db = await database;
    final maps = await db.query(
      'survey_responses',
      where: 'surveyFlowId = ?',
      whereArgs: [surveyFlowId],
    );
    if (maps.isEmpty) return null;
    final map = maps.first;
    return SurveyResponse(
      surveyFlowId: map['surveyFlowId'] as String,
      surveyId: map['surveyId'] as String,
      answers: Map<String, int>.from(jsonDecode(map['answers_json'] as String)),
    );
  }

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

  Future<List<AssessmentResult>> getResultsBySurvey(String surveyId) async {
    final db = await database;
    final maps = await db.rawQuery(
      '''
      SELECT ar.surveyFlowId, ar.scores, ar.timestamp
      FROM assessment_results ar
      INNER JOIN survey_responses sr ON sr.surveyFlowId = ar.surveyFlowId
      WHERE sr.surveyId = ?
      ORDER BY ar.timestamp DESC
      ''',
      [surveyId],
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

  Future<void> clearAssessmentHistory() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('assessment_results');
      await txn.delete('survey_responses');
    });
  }
}
