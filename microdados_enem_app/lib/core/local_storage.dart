import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool getBool(String key, bool defaultValue) =>
      _prefs.getBool(key) ?? defaultValue;

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String getString(String key, String defaultValue) =>
      _prefs.getString(key) ?? defaultValue;
}

class StorageKeys {
  StorageKeys._();

  static const isOnboardingComplete = 'is_onboarding_complete';
  static const subscription = 'subscription';
}
