import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/answer_score_analysis/data/models.dart';

typedef AnswerScoreRelationState =
    EndpointState<String, AnswerScoreRelationStateData>;

class AnswerScoreRelationStateData {
  final String minScore;
  final String maxScore;
  final Map<int, int> histogram;
  final bool hasData;

  const AnswerScoreRelationStateData({
    required this.minScore,
    required this.maxScore,
    required this.histogram,
    required this.hasData,
  });

  factory AnswerScoreRelationStateData.fromModel(
    AnswerScoreRelationResponse model,
  ) {
    return AnswerScoreRelationStateData(
      minScore: model.minScore.toString(),
      maxScore: model.maxScore.toString(),
      histogram: model.histogram,
      hasData: model.hasData,
    );
  }
}
