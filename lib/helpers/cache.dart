import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool(String key, bool value) async {
    log('setBool: $key, $value');
    return await _prefs.setBool(key, value);
  }

  // static bool? getBool(String key) {
  //   bool? value = _prefs.getBool(key);
  //   log('getBool: $key, $value');
  //   return value;
  // }

  // static bool checkForKey(String key) {
  //   return _prefs.containsKey(key);
  // }

  static Future<bool> saveData(String key, dynamic value) {
    if (value is String)
      return _prefs.setString(key, value);
    else if (value is int)
      return _prefs.setInt(key, value);
    else
      return _prefs.setDouble(key, value);
  }

  static dynamic getData(String key) {
    if (_prefs.containsKey(key)) {
      return _prefs.get(key);
    } else
      return null;
  }

  static Future<bool> logout() {
    // return _prefs.setString('token', 'qqqq');
    return _prefs.remove('token');
  }
}
