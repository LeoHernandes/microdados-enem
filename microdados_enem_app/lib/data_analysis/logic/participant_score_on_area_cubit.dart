import 'package:bloc/bloc.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/data/data_analysis_repository.dart';
import 'package:microdados_enem_app/data_analysis/logic/participant_score_on_area_state.dart';

class ParticipantScoreOnAreaCubit extends Cubit<ParticipantScoreOnAreaState> {
  final DataAnalysisRepository _repository = DataAnalysisRepository();

  ParticipantScoreOnAreaCubit()
    : super(const ParticipantScoreOnAreaState.idle());

  Future<void> getParticipantScoreData(String id, ExamArea area) async {
    emit(const ParticipantScoreOnAreaState.loading());

    await _repository
        .getParticipantScoreOnArea(id, area)
        .then(
          (value) => emit(
            ParticipantScoreOnAreaState.success(
              ParticipantScoreOnAreaStateData.fromModel(value),
            ),
          ),
          onError:
              (_) => emit(
                ParticipantScoreOnAreaState.error(
                  'Não foi possível encontrar as informações da tela inicial. Tente novamente mais tarde!',
                ),
              ),
        );
  }
}
