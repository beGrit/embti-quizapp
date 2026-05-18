import 'package:emombti/data/services/persistence/local/local_data_sqlite_service.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';

import 'survey_flow_repository.dart';

/// Local implementation of [SurveyFlowRepository] backed by SQLite
/// ([LocalDataSqliteService]).
class SurveyFlowRepositoryLocal implements SurveyFlowRepository {
  final LocalDataSqliteService _localDataSqliteService;

  SurveyFlowRepositoryLocal({LocalDataSqliteService? localDataSqliteService})
    : _localDataSqliteService =
          localDataSqliteService ?? LocalDataSqliteService();

  @override
  Future<SurveyFlow?> getFlowById(String id) =>
      _localDataSqliteService.getFlow(id);

  @override
  Future<List<SurveyFlow>> getFlows({String? surveyId}) =>
      _localDataSqliteService.getFlows(surveyId: surveyId);

  @override
  Future<void> saveFlow(SurveyFlow flow) =>
      _localDataSqliteService.saveFlow(flow);

  @override
  Future<void> deleteFlow(String id) =>
      _localDataSqliteService.deleteFlow(id);
}
