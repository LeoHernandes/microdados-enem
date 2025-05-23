import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/answer_score_analysis/data/answer_score_analysis_repository.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/participant_score_on_area_state.dart';

class ParticipantScoreOnAreaCubit extends Cubit<ParticipantScoreOnAreaState> {
  final AnswerScoreAnalysisRepository _repository =
      AnswerScoreAnalysisRepository();

  ParticipantScoreOnAreaCubit()
    : super(const ParticipantScoreOnAreaState.idle());

  Future<void> getParticipantScoreOnAreaData(
    BuildContext context,
    String id,
    ExamArea area,
  ) async {
    emit(const ParticipantScoreOnAreaState.loading());

    await _repository
        .getParticipantScoreOnArea(context, id, area)
        .then(
          (value) => emit(
            ParticipantScoreOnAreaState.success(
              ParticipantScoreOnAreaStateData.fromModel(value),
            ),
          ),
          onError:
              (_) => emit(
                ParticipantScoreOnAreaState.error(
                  'Não foi possível encontrar suas informações. Tente novamente mais tarde!',
                ),
              ),
        );
  }
}
