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

class ParticipantPedagogicalCoherenceResponse {
  final String examColor;
  final int rightAnswers;
  final Map<double, QuestionHit> difficultyRule;

  ParticipantPedagogicalCoherenceResponse({
    required this.examColor,
    required this.rightAnswers,
    required this.difficultyRule,
  });

  factory ParticipantPedagogicalCoherenceResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return switch (json) {
      {
        'examColor': final examColor,
        'rightAnswers': final rightAnswers,
        'difficultyRule': final Map<String, dynamic> difficultyRule,
      } =>
        ParticipantPedagogicalCoherenceResponse(
          examColor: examColor,
          rightAnswers: rightAnswers.toInt(),
          difficultyRule: difficultyRule.map(
            (key, value) =>
                MapEntry(double.parse(key), QuestionHit.fromJson(value)),
          ),
        ),
      _ =>
        throw FormatException(
          'Failed to parse question difficulty ${json.toString()}',
        ),
    };
  }
}

class QuestionHit {
  final int position;
  final bool hit;

  const QuestionHit({required this.position, required this.hit});

  factory QuestionHit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'position': final position, 'hit': final bool hit} => QuestionHit(
        position: position.toInt(),
        hit: hit,
      ),
      _ =>
        throw FormatException(
          'Failed to parse question difficulty ${json.toString()}',
        ),
    };
  }
}
