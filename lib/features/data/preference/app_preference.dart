import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const notifKey = 'key_notif';

  static Future<void> setNotif(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notifKey, value);
    print('PREFERENCE: Notif Preference : ${prefs.getBool(notifKey)}');
  }

  static Future<bool?> getNotif() async {
    final prefs = await SharedPreferences.getInstance();
    print('PREFERENCE: Notif Preference : ${prefs.getBool(notifKey)}');
    return prefs.getBool(notifKey);
  }
}
