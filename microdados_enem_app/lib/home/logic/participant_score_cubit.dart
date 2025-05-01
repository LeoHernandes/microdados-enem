import 'package:bloc/bloc.dart';
import 'package:microdados_enem_app/home/data/participant_score_repository.dart';
import 'package:microdados_enem_app/home/logic/participant_score_state.dart';

class ParticipantScoreCubit extends Cubit<ParticipantScoreState> {
  final ParticipantScoreRepository _repository = ParticipantScoreRepository();

  ParticipantScoreCubit() : super(const ParticipantScoreState.idle());

  Future<void> getParticipantScoreData(String subscription) async {
    emit(const ParticipantScoreState.loading());

    await _repository
        .getParticipantScoreData(subscription)
        .then(
          (value) => emit(
            ParticipantScoreState.success(
              ParticipantScoreStateData.fromModel(value),
            ),
          ),
          onError:
              (_) => emit(
                ParticipantScoreState.error(
                  'Não foi possível encontrar as informações da tela inicial. Tente novamente mais tarde!',
                ),
              ),
        );
  }
}
