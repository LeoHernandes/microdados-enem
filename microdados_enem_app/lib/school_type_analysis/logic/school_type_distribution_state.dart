import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/school_type_analysis/data/models.dart';

typedef SchoolTypeDistributionState =
    EndpointState<String, SchoolTypeDistributionStateData>;

class SchoolTypeDistributionStateData {
  final int unknownCount;
  final int publicCount;
  final int privateCount;

  const SchoolTypeDistributionStateData({
    required this.unknownCount,
    required this.publicCount,
    required this.privateCount,
  });

  factory SchoolTypeDistributionStateData.fromModel(
    SchoolTypeDistrubtionResponse model,
  ) {
    return SchoolTypeDistributionStateData(
      unknownCount: model.unknownCount,
      publicCount: model.publicCount,
      privateCount: model.privateCount,
    );
  }
}
