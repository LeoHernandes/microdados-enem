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

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  int getInt(String key, int defaultValue) =>
      _prefs.getInt(key) ?? defaultValue;

  Future<void> removeKeysStartingWith(String pattern) async {
    final allKeys = _prefs.getKeys();
    final keysToRemove =
        allKeys.where((key) => key.startsWith(pattern)).toList();

    await Future.wait(keysToRemove.map((key) => _prefs.remove(key)));
  }
}

class StorageKeys {
  StorageKeys._();

  static const isOnboardingComplete = 'is_onboarding_complete';
  static const appCacheId = 'app_cache_id';
  static const subscription = 'subscription';
  static const cachePrefix = 'CACHE_';
}
