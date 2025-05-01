import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';

class ParticipantScoreRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  ParticipantScoreRepository();

  Future<ParticipantScoreResponse> getParticipantScoreData(
    BuildContext context,
    String subscription,
  ) async {
    final route = 'participant/$subscription/score';
    final response = await _httpClient.get(
      route,
      cache: AppCache(context: context, key: route),
    );
    return ParticipantScoreResponse.fromJson(response);
  }
}

class ParticipantScoreResponse {
  final double scoreLC;
  final double scoreCH;
  final double scoreCN;
  final double scoreMT;
  final double scoreRE;
  final double scoreMean;

  const ParticipantScoreResponse({
    required this.scoreLC,
    required this.scoreCH,
    required this.scoreCN,
    required this.scoreMT,
    required this.scoreRE,
    required this.scoreMean,
  });

  factory ParticipantScoreResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'scoreLC': final scoreLC,
        'scoreCH': final scoreCH,
        'scoreCN': final scoreCN,
        'scoreMT': final scoreMT,
        'scoreRE': final scoreRE,
        'scoreMean': final scoreMean,
      } =>
        ParticipantScoreResponse(
          scoreLC: scoreLC.toDouble(),
          scoreCH: scoreCH.toDouble(),
          scoreCN: scoreCN.toDouble(),
          scoreMT: scoreMT.toDouble(),
          scoreRE: scoreRE.toDouble(),
          scoreMean: scoreMean.toDouble(),
        ),
      _ => throw const FormatException('Failed to load participant score.'),
    };
  }
}
