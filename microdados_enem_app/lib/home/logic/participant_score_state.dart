import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/home/data/participant_score_repository.dart';

typedef ParticipantScoreState =
    EndpointState<String, ParticipantScoreStateData>;

class ParticipantScoreStateData {
  final String scoreLC;
  final String scoreCH;
  final String scoreCN;
  final String scoreMT;
  final String scoreRE;
  final String scoreMean;

  const ParticipantScoreStateData({
    required this.scoreLC,
    required this.scoreCH,
    required this.scoreCN,
    required this.scoreMT,
    required this.scoreRE,
    required this.scoreMean,
  });

  factory ParticipantScoreStateData.fromModel(ParticipantScoreResponse model) {
    return ParticipantScoreStateData(
      scoreLC: model.scoreLC.toString(),
      scoreCH: model.scoreCH.toString(),
      scoreCN: model.scoreCN.toString(),
      scoreMT: model.scoreMT.toString(),
      scoreRE: model.scoreRE.toString(),
      scoreMean: model.scoreMean.toString(),
    );
  }
}
