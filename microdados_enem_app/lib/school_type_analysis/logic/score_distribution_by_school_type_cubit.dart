import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/school_type_analysis/data/school_type_analysis_repository.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_distribution_by_school_type_state.dart';

class ScoreDistributionBySchoolTypeCubit
    extends Cubit<ScoreDistributionBySchoolTypeState> {
  final SchoolTypeAnalysisRepository _repository =
      SchoolTypeAnalysisRepository();
  int _currentRequestId = 0;

  ScoreDistributionBySchoolTypeCubit()
    : super(const ScoreDistributionBySchoolTypeState.idle());

  Future<void> getScoreDistributionBySchoolTypeData(
    BuildContext context,
    ExamArea area,
  ) async {
    final requestId = ++_currentRequestId;
    emit(const ScoreDistributionBySchoolTypeState.loading());

    await _repository
        .getScoreDistributionBySchoolType(context, area)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                ScoreDistributionBySchoolTypeState.success(
                  ScoreDistributionBySchoolTypeStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (error) {
            if (requestId == _currentRequestId) {
              emit(
                ScoreDistributionBySchoolTypeState.error(
                  'Não foi possível encontrar os dados da análise. Tente novamente mais tarde!',
                ),
              );
              debugPrint(error);
            }
          },
        );
  }
}
