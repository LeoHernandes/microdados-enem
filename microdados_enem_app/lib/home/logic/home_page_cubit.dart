import 'package:bloc/bloc.dart';
import 'package:microdados_enem_app/home/data/home_page_repository.dart';
import 'package:microdados_enem_app/home/logic/home_page_state.dart';

class HomePageStateCubit extends Cubit<HomePageState> {
  final HomePageRepository _repository = HomePageRepository();

  HomePageStateCubit() : super(const HomePageState.idle());

  Future<void> getHomePageData() async {
    emit(const HomePageState.loading());

    // TODO: change this response to a unwrappable
    //       structure to improve readability
    try {
      final response = await _repository.getHomePageData();
      emit(HomePageState.success(HomePageStateData.fromModel(response)));
    } on Exception catch (e) {
      emit(HomePageState.error(e.toString()));
    }
  }
}
