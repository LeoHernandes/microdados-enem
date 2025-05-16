import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/answer_score_analysis/data/answer_score_analysis_repository.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/canceled_questions_count_state.dart';

class CanceledQuestionsCountCubit extends Cubit<CanceledQuestionsCountState> {
  final AnswerScoreAnalysisRepository _repository =
      AnswerScoreAnalysisRepository();

  CanceledQuestionsCountCubit()
    : super(const CanceledQuestionsCountState.idle());

  Future<void> getCanceledQuestionsCountData(
    BuildContext context,
    ExamArea area,
    bool isReapplication,
  ) async {
    emit(const CanceledQuestionsCountState.loading());

    await _repository
        .getCanceledQuestionsCount(context, area, isReapplication)
        .then(
          (value) => emit(
            CanceledQuestionsCountState.success(
              CanceledQuestionsCountStateData.fromModel(value),
            ),
          ),
          onError:
              (_) => emit(
                CanceledQuestionsCountState.error(
                  'Não foi possível encontrar suas informações. Tente novamente mais tarde!',
                ),
              ),
        );
  }
}
