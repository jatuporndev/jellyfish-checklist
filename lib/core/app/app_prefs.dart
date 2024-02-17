import 'dart:async';

import 'package:jellyfish/core/app/constrains.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _key = "key";

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

  Future<void> setKey(String key) async {
   await _sharedPreferences.setString(_key, key);
  }

  String getKey() {
    String? key = _sharedPreferences.getString(_key);
    if (key != null && key.isNotEmpty) {
      return key;
    } else {
      return Constants.empty;
    }
  }
}
