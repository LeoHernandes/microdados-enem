import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/enem/foreign_language.dart';

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
}

class DifficultyDistributionResponse {
  final String color;
  final QuestionDifficulty easiestQuestion;
  final QuestionDifficulty hardestQuestion;
  final Map<int, double?> distribution;

  const DifficultyDistributionResponse({
    required this.color,
    required this.easiestQuestion,
    required this.hardestQuestion,
    required this.distribution,
  });

  factory DifficultyDistributionResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'color': final color,
        'easiestQuestion': final Map<String, dynamic> easiestQuestion,
        'hardestQuestion': final Map<String, dynamic> hardestQuestion,
        'distribution': final Map<String, dynamic> distribution,
      } =>
        DifficultyDistributionResponse(
          color: color,
          easiestQuestion: QuestionDifficulty.fromJson(easiestQuestion),
          hardestQuestion: QuestionDifficulty.fromJson(hardestQuestion),
          distribution: distribution.map(
            (key, value) => MapEntry(int.parse(key), value?.toDouble()),
          ),
        ),
      _ =>
        throw const FormatException('Failed to parse difficulty distribution.'),
    };
  }
}

class QuestionDifficulty {
  final int position;
  final double difficulty;

  const QuestionDifficulty({required this.position, required this.difficulty});

  factory QuestionDifficulty.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'position': final position, 'difficulty': final difficulty} =>
        QuestionDifficulty(
          position: position.toInt(),
          difficulty: difficulty.toDouble(),
        ),
      _ =>
        throw FormatException(
          'Failed to parse question difficulty ${json.toString()}',
        ),
    };
  }
}
