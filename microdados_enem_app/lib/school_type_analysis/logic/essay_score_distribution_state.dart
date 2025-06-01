import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/school_type_analysis/data/models.dart';

typedef EssayScoreDistributionState =
    EndpointState<String, EssayScoreDistributionStateData>;

class EssayScoreDistributionStateData {
  final Map<int, int> publicSchoolDistribution;
  final Map<int, int> privateSchoolDistribution;

  const EssayScoreDistributionStateData({
    required this.publicSchoolDistribution,
    required this.privateSchoolDistribution,
  });

  factory EssayScoreDistributionStateData.fromModel(
    ScoreDistributionBySchoolTypeResponse model,
  ) {
    return EssayScoreDistributionStateData(
      publicSchoolDistribution: model.publicSchoolDistribution,
      privateSchoolDistribution: model.privateSchoolDistribution,
    );
  }
}
