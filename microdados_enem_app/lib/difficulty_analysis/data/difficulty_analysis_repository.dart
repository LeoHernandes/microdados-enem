import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/enem/foreign_language.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/models.dart';

class DifficultyAnalysisRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  DifficultyAnalysisRepository();

  Future<DifficultyDistributionResponse> getDifficultyDistribution(
    BuildContext context,
    ExamArea area,
    ForeignLanguage? language,
  ) async {
    final route =
        language == null
            ? 'analysis/difficulty-distribution/${area.name}'
            : 'analysis/difficulty-distribution/${area.name}?language=${language.index}';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );

    return DifficultyDistributionResponse.fromJson(response);
  }

  Future<ParticipantPedagogicalCoherenceResponse>
  getParticipantPedagogicalCoherence(
    BuildContext context,
    ExamArea area,
    String id,
  ) async {
    final route = 'participant/$id/pedagogical-coherence/${area.name}';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );

    return ParticipantPedagogicalCoherenceResponse.fromJson(response);
  }
}
