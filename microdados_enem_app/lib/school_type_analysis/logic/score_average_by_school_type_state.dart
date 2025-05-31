import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/school_type_analysis/data/models.dart';

typedef ScoreAverageBySchoolTypeState =
    EndpointState<String, ScoreAverageBySchoolTypeStateData>;

class ScoreAverageBySchoolTypeStateData {
  final Scores publicSchoolScores;
  final Scores privateSchoolScores;

  const ScoreAverageBySchoolTypeStateData({
    required this.publicSchoolScores,
    required this.privateSchoolScores,
  });

  factory ScoreAverageBySchoolTypeStateData.fromModel(
    ScoreAverageBySchoolTypeResponse model,
  ) {
    return ScoreAverageBySchoolTypeStateData(
      publicSchoolScores: model.publicSchoolScores,
      privateSchoolScores: model.privateSchoolScores,
    );
  }
}
