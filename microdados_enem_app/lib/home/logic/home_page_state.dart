import 'package:microdados_enem_app/core/api/endpoint_state.dart';
import 'package:microdados_enem_app/home/data/home_page_repository.dart';

typedef HomePageState = EndpointState<String, HomePageStateData>;

class HomePageStateData {
  final int count;

  const HomePageStateData({required this.count});

  factory HomePageStateData.fromModel(HomePageDataResponse model) {
    return HomePageStateData(count: model.count);
  }
}
