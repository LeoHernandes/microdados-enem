import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/school_type_analysis/data/school_type_analysis_repository.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_average_by_school_type_state.dart';

class ScoreAverageBySchoolTypeCubit
    extends Cubit<ScoreAverageBySchoolTypeState> {
  final SchoolTypeAnalysisRepository _repository =
      SchoolTypeAnalysisRepository();
  int _currentRequestId = 0;

  ScoreAverageBySchoolTypeCubit()
    : super(const ScoreAverageBySchoolTypeState.idle());

  Future<void> getScoreAverageBySchoolTypeData(BuildContext context) async {
    final requestId = ++_currentRequestId;
    emit(const ScoreAverageBySchoolTypeState.loading());

    await _repository
        .getScoreAverageBySchoolType(context)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                ScoreAverageBySchoolTypeState.success(
                  ScoreAverageBySchoolTypeStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (error) {
            if (requestId == _currentRequestId) {
              emit(
                ScoreAverageBySchoolTypeState.error(
                  'Não foi possível encontrar os dados da análise. Tente novamente mais tarde!',
                ),
              );
              debugPrint(error);
            }
          },
        );
  }
}
