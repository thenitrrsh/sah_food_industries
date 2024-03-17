

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants_values.dart';

class SharedPreferencesHelper {
  static SharedPreferences? prefs;
  static String _prefix = "showTalent";
  static var userBox;

  static initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool isIntro() {
    return prefs?.getBool(ConstantsValues.isIntro) ?? false;
  }

  static Future<bool>? setIntro() {
    return prefs?.setBool(ConstantsValues.isIntro, true);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user login or not , null if not set
  /// ------------------------------------------------------------
  static bool isLogin() {
    bool? isLogin;
    isLogin = prefs?.getBool(ConstantsValues.isLogin) ?? false;
    return isLogin;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user login
  /// ----------------------------------------------------------
  static Future<bool?> setIsLogin(bool isLogin) async {
    return await prefs?.setBool(ConstantsValues.isLogin, isLogin);
  }

  static clearSharedPreferences() async {
    prefs?.clear();
  }

  static logout() async {
    await FirebaseAuth.instance.signOut();
    clearSharedPreferences();

  }


}
