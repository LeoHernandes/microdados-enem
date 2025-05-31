import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/school_type_analysis/data/school_type_analysis_repository.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/school_type_distribution_state.dart';

class SchoolTypeDistributionCubit extends Cubit<SchoolTypeDistributionState> {
  final SchoolTypeAnalysisRepository _repository =
      SchoolTypeAnalysisRepository();
  int _currentRequestId = 0;

  SchoolTypeDistributionCubit()
    : super(const SchoolTypeDistributionState.idle());

  Future<void> getSchoolTypeDistributionData(BuildContext context) async {
    final requestId = ++_currentRequestId;
    emit(const SchoolTypeDistributionState.loading());

    await _repository
        .getSchoolTypeDistribution(context)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                SchoolTypeDistributionState.success(
                  SchoolTypeDistributionStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (error) {
            if (requestId == _currentRequestId) {
              emit(
                SchoolTypeDistributionState.error(
                  'Não foi possível encontrar os dados da análise. Tente novamente mais tarde!',
                ),
              );
              debugPrint(error);
            }
          },
        );
  }
}
