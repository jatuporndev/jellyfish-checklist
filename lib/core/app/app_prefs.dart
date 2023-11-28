import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> clearAll() async {
    try {
      await _sharedPreferences.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> setToken() async {

  }

  String getAccessToken() {
    return "";
  }
}
