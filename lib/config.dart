import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static const String _defaultBaseUrl = 'http://192.168.1.8:3500/';
  static const String _baseUrlKey = 'server_address';

  static Future<String> getBaseUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_baseUrlKey) ?? _defaultBaseUrl;
  }

  static Future<void> setBaseUrl(String newBaseUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_baseUrlKey, newBaseUrl);
  }

  static Future<String> getRegisterUrl() async {
    return '${await getBaseUrl()}api/users/register';
  }

  static Future<String> getLoginUrl() async {
    return '${await getBaseUrl()}api/users/login';
  }
}
