import 'package:microdados_enem_app/core/api/microdados_api.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class DataAnalysisRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  DataAnalysisRepository();

  Future<ParticipantScoreOnAreaResponse> getParticipantScoreOnArea(
    String id,
    ExamArea area,
  ) async {
    final response = await _httpClient.get(
      'participant/$id/score-on-area/${area.name}',
      timeout: Duration(seconds: 5),
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
