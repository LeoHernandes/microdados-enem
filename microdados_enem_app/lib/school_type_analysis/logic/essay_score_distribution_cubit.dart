import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/school_type_analysis/data/school_type_analysis_repository.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/essay_score_distribution_state.dart';

class EssayScoreDistributionCubit extends Cubit<EssayScoreDistributionState> {
  final SchoolTypeAnalysisRepository _repository =
      SchoolTypeAnalysisRepository();
  int _currentRequestId = 0;

  EssayScoreDistributionCubit()
    : super(const EssayScoreDistributionState.idle());

  Future<void> getEssayScoreDistributionData(BuildContext context) async {
    final requestId = ++_currentRequestId;
    emit(const EssayScoreDistributionState.loading());

    await _repository
        .getScoreDistributionBySchoolTypeForEssay(context)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                EssayScoreDistributionState.success(
                  EssayScoreDistributionStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (error) {
            if (requestId == _currentRequestId) {
              emit(
                EssayScoreDistributionState.error(
                  'Não foi possível encontrar os dados da análise. Tente novamente mais tarde!',
                ),
              );
              debugPrint(error);
            }
          },
        );
  }
}
