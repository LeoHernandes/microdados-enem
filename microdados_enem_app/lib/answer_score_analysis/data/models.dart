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

class AnswerScoreRelationResponse {
  final double minScore;
  final double maxScore;
  final Map<int, int> histogram;
  final bool hasData;

  const AnswerScoreRelationResponse({
    required this.minScore,
    required this.maxScore,
    required this.histogram,
  }) : this.hasData = true;

  AnswerScoreRelationResponse.noData()
    : this.minScore = 0,
      this.maxScore = 0,
      this.histogram = {},
      this.hasData = false;

  factory AnswerScoreRelationResponse.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return AnswerScoreRelationResponse.noData();
    }

    return switch (json) {
      {
        'minScore': final minScore,
        'maxScore': final maxScore,
        'histogram': final Map<String, dynamic> histogram,
      } =>
        AnswerScoreRelationResponse(
          minScore: minScore.toDouble(),
          maxScore: maxScore.toDouble(),
          histogram: histogram.map(
            (key, value) => MapEntry(int.parse(key), value as int),
          ),
        ),
      _ =>
        throw const FormatException(
          'Failed to load analysis answer score relation.',
        ),
    };
  }
}

class CanceledQuestionsCountResponse {
  final int count;

  const CanceledQuestionsCountResponse({required this.count});

  factory CanceledQuestionsCountResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'count': final count} => CanceledQuestionsCountResponse(
        count: count.toInt(),
      ),
      _ =>
        throw const FormatException(
          'Failed to load canceled questions count on area.',
        ),
    };
  }
}
