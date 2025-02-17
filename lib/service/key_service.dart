import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class KeyService {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> storeUserData(Map<String, dynamic> userData) async {
    await _sharedPreferences.setString('userData', jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> retrieveUserData() async {
    String? jsonString = _sharedPreferences.getString('login_data');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  Future<void> storeValue(String key, dynamic value) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<void> storebool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  Future<String?> retrieveValue(String key) async {
    return _sharedPreferences.getString(key);
  }

  Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }

  Future<void> removeKey(String key) async {
    await _sharedPreferences.remove(key);
  }
}
