import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/school_type_analysis/data/models.dart';

typedef ScoreDistributionBySchoolTypeState =
    EndpointState<String, ScoreDistributionBySchoolTypeStateData>;

class ScoreDistributionBySchoolTypeStateData {
  final Map<int, int> publicSchoolDistribution;
  final Map<int, int> privateSchoolDistribution;

  const ScoreDistributionBySchoolTypeStateData({
    required this.publicSchoolDistribution,
    required this.privateSchoolDistribution,
  });

  factory ScoreDistributionBySchoolTypeStateData.fromModel(
    ScoreDistributionBySchoolTypeResponse model,
  ) {
    return ScoreDistributionBySchoolTypeStateData(
      publicSchoolDistribution: model.publicSchoolDistribution,
      privateSchoolDistribution: model.privateSchoolDistribution,
    );
  }
}
