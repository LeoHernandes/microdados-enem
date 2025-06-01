class SchoolTypeDistrubtionResponse {
  final int unknownCount;
  final int publicCount;
  final int privateCount;

  const SchoolTypeDistrubtionResponse({
    required this.unknownCount,
    required this.publicCount,
    required this.privateCount,
  });

  factory SchoolTypeDistrubtionResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'unknownCount': final unknownCount,
        'publicCount': final publicCount,
        'privateCount': final privateCount,
      } =>
        SchoolTypeDistrubtionResponse(
          unknownCount: unknownCount.toInt(),
          publicCount: publicCount.toInt(),
          privateCount: privateCount.toInt(),
        ),
      _ =>
        throw const FormatException(
          'Failed to load analysis school type distribution.',
        ),
    };
  }
}

class ScoreAverageBySchoolTypeResponse {
  final Scores publicSchoolScores;
  final Scores privateSchoolScores;

  const ScoreAverageBySchoolTypeResponse({
    required this.publicSchoolScores,
    required this.privateSchoolScores,
  });

  factory ScoreAverageBySchoolTypeResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'publicSchoolScores': final Map<String, dynamic> publicSchoolScores,
        'privateSchoolScores': final Map<String, dynamic> privateSchoolScores,
      } =>
        ScoreAverageBySchoolTypeResponse(
          publicSchoolScores: Scores.fromJson(publicSchoolScores),
          privateSchoolScores: Scores.fromJson(privateSchoolScores),
        ),
      _ =>
        throw const FormatException(
          'Failed to parse sccore average by school type.',
        ),
    };
  }
}

class Scores {
  final double averageCH;
  final double averageCN;
  final double averageLC;
  final double averageMT;
  final double averageEssay;

  const Scores({
    required this.averageCH,
    required this.averageCN,
    required this.averageLC,
    required this.averageMT,
    required this.averageEssay,
  });

  factory Scores.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'averageCH': final averageCH,
        'averageCN': final averageCN,
        'averageLC': final averageLC,
        'averageMT': final averageMT,
        'averageEssay': final averageEssay,
      } =>
        Scores(
          averageCH: averageCH.toDouble(),
          averageCN: averageCN.toDouble(),
          averageLC: averageLC.toDouble(),
          averageMT: averageMT.toDouble(),
          averageEssay: averageEssay.toDouble(),
        ),
      _ =>
        throw const FormatException(
          'Failed to load analysis school type distribution.',
        ),
    };
  }
}

class ScoreDistributionBySchoolTypeResponse {
  final Map<int, int> publicSchoolDistribution;
  final Map<int, int> privateSchoolDistribution;

  const ScoreDistributionBySchoolTypeResponse({
    required this.publicSchoolDistribution,
    required this.privateSchoolDistribution,
  });

  factory ScoreDistributionBySchoolTypeResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return switch (json) {
      {
        'publicSchoolDistribution':
            final Map<String, dynamic> publicSchoolDistribution,
        'privateSchoolDistribution':
            final Map<String, dynamic> privateSchoolDistribution,
      } =>
        ScoreDistributionBySchoolTypeResponse(
          publicSchoolDistribution: publicSchoolDistribution.map(
            (key, value) => MapEntry(int.parse(key), value as int),
          ),
          privateSchoolDistribution: privateSchoolDistribution.map(
            (key, value) => MapEntry(int.parse(key), value as int),
          ),
        ),
      _ =>
        throw const FormatException(
          'Failed to parse score distribution by school type.',
        ),
    };
  }
}
