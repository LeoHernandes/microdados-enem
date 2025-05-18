import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/models.dart';

typedef DifficultyDistributionState =
    EndpointState<String, DifficultyDistributionStateData>;

class DifficultyDistributionStateData {
  final String color;
  final QuestionDifficulty easiestQuestion;
  final QuestionDifficulty hardestQuestion;
  final Map<int, double?> distribution;

  const DifficultyDistributionStateData({
    required this.color,
    required this.easiestQuestion,
    required this.hardestQuestion,
    required this.distribution,
  });

  factory DifficultyDistributionStateData.fromModel(
    DifficultyDistributionResponse model,
  ) {
    return DifficultyDistributionStateData(
      color: model.color.toString(),
      easiestQuestion: model.easiestQuestion,
      hardestQuestion: model.hardestQuestion,
      distribution: model.distribution,
    );
  }
}
