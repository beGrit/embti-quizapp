import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/quiz/quiz_api_model.dart';
import 'package:emombti/data/services/persistence/local/local_storage.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'quiz_repository.dart';

/// Local implementation of [QuizRepository] backed by SQLite and Firestore
class QuizRepositoryDev implements QuizRepository {
  final LocalStorage localStorage;
  final FirestoreService firestoreService;
  final _log = Logger('QuizRepositoryDev');

  QuizRepositoryDev({
    required this.localStorage,
    required this.firestoreService,
  });

  @override
  Future<List<Survey>> getAvailableSurveys() async {
    try {
      return await localStorage.getQuizzes();
    } catch (e) {
      debugPrint('Error loading surveys: $e');
      return [];
    }
  }

  @override
  Future<Survey?> getSurveyById(String id) => localStorage.getSurvey(id);

  @override
  Future<List<AssessmentResult>> getAssessmentHistory() async {
    try {
      return await localStorage.getAllAssessmentResults();
    } catch (e) {
      debugPrint('Error loading assessment history: $e');
      return [];
    }
  }

  @override
  Future<void> clearHistory() async {
    await localStorage.clearAssessmentHistory();
  }

  @override
  Future<SurveyFlow?> getFlowById(String id) async {
    return await localStorage.getFlow(id);
  }

  @override
  Future<List<SurveyFlow>> getFlows({String? surveyId}) async {
    return await localStorage.getFlows(surveyId: surveyId);
  }

  @override
  Future<void> saveFlow(SurveyFlow flow) async {
    // 1. Save locally first (offline-first)
    await localStorage.saveFlow(flow);

    // 2. Background sync
    _syncFlowToRemote(flow);
  }

  Future<void> _syncFlowToRemote(SurveyFlow flow) async {
    try {
      String? userId = flow.userId;
      if (userId != null) {
        final apiModel = SurveyFlowApiModel.fromDomain(flow);
        await firestoreService.saveSurveyFlow(userId, apiModel);
        // 3. Mark as synchronized upon success
        final updatedFlow = flow.copyWith(synchronized: true);
        await localStorage.saveFlow(updatedFlow);
      }
    } catch (e) {
      _log.warning('Failed to save flow to Firestore: $e');
    }
  }

  @override
  Future<void> deleteFlow(SurveyFlow flow) async {
    await localStorage.deleteFlow(flow.id);
    try {
      var userId = flow.userId;
      if (userId != null) {
        await firestoreService.deleteSurveyFlow(userId, flow.id);
      }
    } catch (e) {
      _log.warning('Failed to delete flow from Firestore: $e');
    }
  }

  @override
  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId) async {
    return await localStorage.getAssessmentResult(surveyFlowId);
  }

  @override
  Future<void> saveAssessmentResult(AssessmentResult result) async {
    // 1. Save locally first
    await localStorage.saveResult(result);

    // 2. Background sync
    _syncAssessmentResultToRemote(result);
  }

  Future<void> _syncAssessmentResultToRemote(AssessmentResult result) async {
    try {
      var userId = result.userId;
      if (userId != null) {
        final apiModel = AssessmentResultApiModel.fromDomain(result);
        await firestoreService.saveAssessmentResult(
          userId,
          result.surveyFlowId,
          apiModel,
        );
      }
      // No synchronized flag on AssessmentResult for now as per instructions (only for root data)
    } catch (e) {
      _log.warning('Failed to save assessment result to Firestore: $e');
    }
  }

  @override
  Future<void> syncLocalToRemote() async {
    _log.info('Syncing local to remote');
  }

  @override
  Future<void> syncRemoteFromLocal() async {
    _log.info('Syncing remote from local');
  }

  @override
  Future<void> sync(String userId) async {
    if (userId.isEmpty) return;

    try {
      _log.info('Starting sync for user: $userId');

      // 1. Fetch remote data
      final remoteFlowsApi = await firestoreService.getSurveyFlows(userId);
      final remoteResultsApi =
          await firestoreService.getAllAssessmentResults(userId);

      final remoteFlows = remoteFlowsApi.map((e) => e.toDomain()).toList();
      final remoteResults = remoteResultsApi.map((e) => e.toDomain()).toList();

      // 2. Fetch local data
      final localFlows = await localStorage.getFlows();
      final localResults = await localStorage.getAllAssessmentResults();

      // 3. Remote -> Local (Download missing items)
      for (final remoteFlow in remoteFlows) {
        final localFlow = localFlows.cast<SurveyFlow?>().firstWhere(
              (f) => f?.id == remoteFlow.id,
              orElse: () => null,
            );

        if (localFlow == null) {
          _log.info('Downloading remote flow: ${remoteFlow.id}');
          await localStorage.saveFlow(remoteFlow.copyWith(synchronized: true));

          // Also download result if it exists
          final remoteResult = remoteResults.cast<AssessmentResult?>().firstWhere(
                (r) => r?.surveyFlowId == remoteFlow.id,
                orElse: () => null,
              );
          if (remoteResult != null) {
            await localStorage.saveResult(remoteResult);
          }
        } else if (localFlow.synchronized) {
          // If already synced, we could potentially update local with remote if different
          // For now, let's assume remote is source of truth for synced data
          await localStorage.saveFlow(remoteFlow.copyWith(synchronized: true));

          final remoteResult = remoteResults.cast<AssessmentResult?>().firstWhere(
                (r) => r?.surveyFlowId == remoteFlow.id,
                orElse: () => null,
              );
          if (remoteResult != null) {
            await localStorage.saveResult(remoteResult);
          }
        }
      }

      // 4. Local -> Remote (Upload unsynced items)
      for (final localFlow in localFlows) {
        if (!localFlow.synchronized) {
          _log.info('Uploading local flow: ${localFlow.id}');
          await _syncFlowToRemote(localFlow.copyWith(userId: userId));

          // Also upload result if it exists
          final localResult = localResults.cast<AssessmentResult?>().firstWhere(
                (r) => r?.surveyFlowId == localFlow.id,
                orElse: () => null,
              );
          if (localResult != null) {
            await _syncAssessmentResultToRemote(localResult.copyWith(userId: userId));
          }
        }
      }

      _log.info('Sync completed successfully');
    } catch (e) {
      _log.severe('Sync failed: $e');
      rethrow;
    }
  }
}
