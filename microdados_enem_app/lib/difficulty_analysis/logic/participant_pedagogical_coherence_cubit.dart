import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/difficulty_analysis_repository.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/participant_pedagogical_coherence_state.dart';

class ParticipantPedagogicalCoherenceCubit
    extends Cubit<ParticipantPedagogicalCoherenceState> {
  final DifficultyAnalysisRepository _repository =
      DifficultyAnalysisRepository();
  int _currentRequestId = 0;

  ParticipantPedagogicalCoherenceCubit()
    : super(const ParticipantPedagogicalCoherenceState.idle());

  Future<void> getParticipantPedagogicalCoherenceData(
    BuildContext context,
    String id,
    ExamArea area,
  ) async {
    final requestId = ++_currentRequestId;
    emit(const ParticipantPedagogicalCoherenceState.loading());

    await _repository
        .getParticipantPedagogicalCoherence(context, area, id)
        .then(
          (value) {
            if (requestId == _currentRequestId) {
              emit(
                ParticipantPedagogicalCoherenceState.success(
                  ParticipantPedagogicalCoherenceStateData.fromModel(value),
                ),
              );
            }
          },
          onError: (error) {
            if (requestId == _currentRequestId) {
              emit(
                ParticipantPedagogicalCoherenceState.error(
                  'Não foi possível encontrar os dados da coerência pedagógica. Tente novamente mais tarde!',
                ),
              );
            }
            debugPrint(error);
          },
        );
  }
}
