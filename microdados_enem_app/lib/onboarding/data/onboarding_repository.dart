import 'package:microdados_enem_app/api/microdados_api.dart';

class OnboardingRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  OnboardingRepository();

  Future<void> postSubscriptionValidate(String subscriptionNumber) async {
    await _httpClient.post('subscription/validate', {
      'subscription': subscriptionNumber,
    }, timeout: Duration(seconds: 5));
  }
}
