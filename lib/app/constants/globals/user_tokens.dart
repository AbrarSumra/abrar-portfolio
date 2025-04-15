import 'package:abrar_portfolio/app/constants/app_keys/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTokens {
  static Future<void> setEmailAddress(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.userEmail, userEmail);
  }

  static Future<void> forgetSetEmailAddress(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.forgetUserEmail, userEmail);
  }

  /*static Future<void> setUserRole(String userRole) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.userRole, userRole);
  }*/

  static Future<void> setUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.userToken, userToken);
  }

  static Future<void> getEmailAddress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString(AppKeys.userEmail);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString(AppKeys.userEmail);
  }
}
