import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

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
      timeout: Duration(seconds: 5),
      cache: AppCache(context: context, key: route),
    );
    return ParticipantScoreOnAreaResponse.fromJson(response);
  }
}

class ParticipantScoreOnAreaResponse {
  final double score;
  final int rightAnswersCount;

  const ParticipantScoreOnAreaResponse({
    required this.score,
    required this.rightAnswersCount,
  });

  factory ParticipantScoreOnAreaResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'score': final score, 'rightAnswersCount': final rightAnswersCount} =>
        ParticipantScoreOnAreaResponse(
          score: score.toDouble(),
          rightAnswersCount: rightAnswersCount.toInt(),
        ),
      _ =>
        throw const FormatException(
          'Failed to load participant score on area.',
        ),
    };
  }
}
