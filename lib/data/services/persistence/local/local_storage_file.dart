import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import '../../../../domain/models/quiz/survey_models.dart';
import '../../../../config/assets.dart';

class LocalStorageFile {
  final String projectName = 'emombti';

  Future<Directory> _getRootDir() async {
    final baseDir = await getDatabasesPath();
    final dir = Directory(join(baseDir, projectName));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<Directory> _getSurveyDir() async {
    final root = await _getRootDir();
    final dir = Directory(join(root.path, 'surveys'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<Survey?> getSurvey(String id) async {
    final dir = await _getSurveyDir();
    final file = File(join(dir.path, '$id.json'));
    if (!await file.exists()) return null;
    final jsonStr = await file.readAsString();
    return Survey.fromJson(jsonDecode(jsonStr));
  }

  Future<void> saveSurvey(Survey survey) async {
    final dir = await _getSurveyDir();
    final file = File(join(dir.path, '${survey.id}.json'));
    await file.writeAsString(jsonEncode(survey.toJson()));
  }

  Future<void> deleteSurvey(String id) async {
    final dir = await _getSurveyDir();
    final file = File(join(dir.path, '$id.json'));
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<List<Survey>> getQuizzes() async {
    final dir = await _getSurveyDir();
    final List<Survey> surveys = [];
    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'));

    if (files.isEmpty) {
      final assetJson = await _loadStringAsset(AppAssets.quizzesJson);
      for (final item in assetJson) {
        final survey = Survey.fromJson(item);
        await saveSurvey(survey);
        surveys.add(survey);
      }
    } else {
      for (final file in files) {
        final jsonStr = await file.readAsString();
        surveys.add(Survey.fromJson(jsonDecode(jsonStr)));
      }
    }
    return surveys;
  }

  Future<List<Map<String, dynamic>>> _loadStringAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }
}
