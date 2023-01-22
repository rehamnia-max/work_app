import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class Settings {
  Future<void> setSettings() async {
    prefs = await SharedPreferences.getInstance();
  }
}
