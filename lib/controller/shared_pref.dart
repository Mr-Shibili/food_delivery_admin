import 'package:shared_preferences/shared_preferences.dart';

class SharedPriference {
  Future<void> setApiToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accesstocken', token);
  }

  Future<String?> getApiToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accesstocken');
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accesstocken');
  }
}
