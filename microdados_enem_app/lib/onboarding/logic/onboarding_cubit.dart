import 'package:bloc/bloc.dart';
import 'package:microdados_enem_app/onboarding/data/onboarding_repository.dart';
import 'package:microdados_enem_app/onboarding/logic/onboarding_state.dart';

class OnboardingStateCubit extends Cubit<OnboardingState> {
  final OnboardingRepository _repository = OnboardingRepository();

  OnboardingStateCubit() : super(const OnboardingState.idle());

  Future<void> postSubscriptionValidate(String subscriptionNumber) async {
    emit(const OnboardingState.loading());

    await _repository
        .postSubscriptionValidate(subscriptionNumber)
        .then(
          (_) => emit(OnboardingState.success(null)),
          onError:
              (_) => emit(
                OnboardingState.error('Número de inscrição não encontrado'),
              ),
        );
  }
}
