import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/data/models.dart';

class DataAnalysisRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  DataAnalysisRepository();

  Future<ParticipantScoreOnAreaResponse> getParticipantScoreOnArea(
    BuildContext context,
    String id,
    ExamArea area,
  ) async {
    final route = 'participant/$id/score-on-area/${area.name}';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );
    return ParticipantScoreOnAreaResponse.fromJson(response);
  }

  Future<AnswerScoreRelationResponse> getAnswerScoreRelation(
    BuildContext context,
    int rightAnswers,
    ExamArea area,
  ) async {
    final route =
        'analysis/answer-score-relation?rightAnswers=$rightAnswers&areaId=${area.name}';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );
    return AnswerScoreRelationResponse.fromJson(response);
  }

  Future<CanceledQuestionsCountResponse> getCanceledQuestionsCount(
    BuildContext context,
    ExamArea area,
    bool isReapplication,
  ) async {
    final route =
        'exam/${area.name}/canceled-questions-count?reapplication=$isReapplication';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );

    return CanceledQuestionsCountResponse.fromJson(response);
  }
}
