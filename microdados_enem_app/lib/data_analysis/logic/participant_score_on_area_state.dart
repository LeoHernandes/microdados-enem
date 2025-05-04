import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/data_analysis/data/models.dart';

typedef ParticipantScoreOnAreaState =
    EndpointState<String, ParticipantScoreOnAreaStateData>;

class ParticipantScoreOnAreaStateData {
  final String score;
  final int rightAnswersCount;

  const ParticipantScoreOnAreaStateData({
    required this.score,
    required this.rightAnswersCount,
  });

  factory ParticipantScoreOnAreaStateData.fromModel(
    ParticipantScoreOnAreaResponse model,
  ) {
    return ParticipantScoreOnAreaStateData(
      score: model.score.toString(),
      rightAnswersCount: model.rightAnswersCount,
    );
  }
}
