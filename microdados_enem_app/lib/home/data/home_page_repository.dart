import 'package:microdados_enem_app/core/api/microdados_api.dart';

class HomePageRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  HomePageRepository();

  Future<HomePageDataResponse> getHomePageData() async {
    final response = await _httpClient.get('participantes');
    return HomePageDataResponse.fromJson(response);
  }
}

class HomePageDataResponse {
  final int count;

  const HomePageDataResponse({required this.count});

  factory HomePageDataResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'count': int count} => HomePageDataResponse(count: count),
      _ => throw const FormatException('Failed to load HomePageDataResponse.'),
    };
  }
}
