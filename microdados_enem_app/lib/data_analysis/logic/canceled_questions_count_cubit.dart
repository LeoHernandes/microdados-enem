import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/data/data_analysis_repository.dart';
import 'package:microdados_enem_app/data_analysis/logic/canceled_questions_count_state.dart';

class CanceledQuestionsCountCubit extends Cubit<CanceledQuestionsCountState> {
  final DataAnalysisRepository _repository = DataAnalysisRepository();

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
