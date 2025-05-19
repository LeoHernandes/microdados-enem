import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/models.dart';

typedef ParticipantPedagogicalCoherenceState =
    EndpointState<String, ParticipantPedagogicalCoherenceStateData>;

class ParticipantPedagogicalCoherenceStateData {
  final String examColor;
  final String rightAnswers;
  final Map<int, bool> difficultyRule;

  const ParticipantPedagogicalCoherenceStateData({
    required this.examColor,
    required this.rightAnswers,
    required this.difficultyRule,
  });

  factory ParticipantPedagogicalCoherenceStateData.fromModel(
    ParticipantPedagogicalCoherenceResponse model,
  ) {
    return ParticipantPedagogicalCoherenceStateData(
      examColor: model.examColor.toString(),
      rightAnswers: model.rightAnswers.toString(),
      difficultyRule: model.difficultyRule,
    );
  }
}
