import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey { userUid, email, isProfileCompleted }

abstract class Preferences {
  Future<void> setString(PrefKey key, String value);

  Future<String?> getString(PrefKey key);

  Future<void> setBool(PrefKey key, bool value);

  Future<bool?> getBool(PrefKey key);

  Future<void> removeKey([List<PrefKey> args = const []]);
}

class PreferencesImpl implements Preferences {
  @override
  Future<void> setString(PrefKey key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key.name, value);
  }

  @override
  Future<String?> getString(PrefKey key, [String? defaultValue]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.name) ?? defaultValue;
  }

  @override
  Future<void> setBool(PrefKey key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key.name, value);
  }

  @override
  Future<bool?> getBool(PrefKey key, [bool? defaultValue]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key.name) ?? defaultValue;
  }

  @override
  Future<void> removeKey([List<PrefKey> args = const []]) async {
    final prefs = await SharedPreferences.getInstance();
    for (PrefKey key in args) {
      prefs.remove(key.name);
    }
  }
}
