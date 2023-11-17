import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static const String esp32IP = '';

  static const int refreshTime = 0;

  static Future<String?> getEsp32IP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(esp32IP);
  }

  static Future<int?> getRefreshTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt("refreshTime");
  }

  static Future<void> saveEsp32IP(String ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(esp32IP, ip);
  }

  static Future<void> saveRefreshTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt("refreshTime", time);
  }
}
