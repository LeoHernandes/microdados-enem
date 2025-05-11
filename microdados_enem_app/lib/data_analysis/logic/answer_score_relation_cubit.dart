import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/data/data_analysis_repository.dart';
import 'package:microdados_enem_app/data_analysis/logic/answer_score_relation_state.dart';

class AnswerScoreRelationCubit extends Cubit<AnswerScoreRelationState> {
  final DataAnalysisRepository _repository = DataAnalysisRepository();
  int _currentRequestId = 0;

  AnswerScoreRelationCubit() : super(const AnswerScoreRelationState.idle());

  Future<void> getAnswerScoreRelationData(
    BuildContext context,
    int rightAnswers,
    ExamArea area,
  ) async {
    final requestId = ++_currentRequestId;
    emit(const AnswerScoreRelationState.loading());

    await _repository
        .getAnswerScoreRelation(context, rightAnswers, area)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                AnswerScoreRelationState.success(
                  AnswerScoreRelationStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (_) {
            if (requestId == _currentRequestId) {
              emit(
                AnswerScoreRelationState.error(
                  'Não foi possível encontrar os dados da análise. Tente novamente mais tarde!',
                ),
              );
            }
          },
        );
  }
}
