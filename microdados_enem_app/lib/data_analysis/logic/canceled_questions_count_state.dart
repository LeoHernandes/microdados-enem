import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/data_analysis/data/models.dart';

typedef CanceledQuestionsCountState =
    EndpointState<String, CanceledQuestionsCountStateData>;

class CanceledQuestionsCountStateData {
  final String count;

  const CanceledQuestionsCountStateData({required this.count});

  factory CanceledQuestionsCountStateData.fromModel(
    CanceledQuestionsCountResponse model,
  ) {
    return CanceledQuestionsCountStateData(count: model.count.toString());
  }
}
