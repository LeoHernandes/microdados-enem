import 'package:bloc/bloc.dart';
import 'package:microdados_enem_app/home/data/home_page_repository.dart';
import 'package:microdados_enem_app/home/logic/home_page_state.dart';

class HomePageStateCubit extends Cubit<HomePageState> {
  final HomePageRepository _repository = HomePageRepository();

  HomePageStateCubit() : super(const HomePageState.idle());

  Future<void> getHomePageData() async {
    emit(const HomePageState.loading());

    await _repository.getHomePageData().then(
      (value) =>
          emit(HomePageState.success(HomePageStateData.fromModel(value))),
      onError:
          (_) => emit(
            HomePageState.error(
              'Não foi possível encontrar as informações da tela inicial. Tente novamente mais tarde!',
            ),
          ),
    );
  }
}
