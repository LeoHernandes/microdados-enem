import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/enem/foreign_language.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/difficulty_analysis_repository.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/answer_score_relation_state.dart';

class DifficultyDistributionCubit extends Cubit<DifficultyDistributionState> {
  final DifficultyAnalysisRepository _repository =
      DifficultyAnalysisRepository();
  int _currentRequestId = 0;

  DifficultyDistributionCubit()
    : super(const DifficultyDistributionState.idle());

  Future<void> getDifficultyDistributionData(
    BuildContext context,
    ExamArea area,
    ForeignLanguage? language,
  ) async {
    final requestId = ++_currentRequestId;
    emit(const DifficultyDistributionState.loading());

    await _repository
        .getDifficultyDistribution(context, area, language)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                DifficultyDistributionState.success(
                  DifficultyDistributionStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (error) {
            if (requestId == _currentRequestId) {
              emit(
                DifficultyDistributionState.error(
                  'Não foi possível encontrar os dados da análise de dificuldade. Tente novamente mais tarde!',
                ),
              );
            }
            debugPrint(error);
          },
        );
  }
}
