import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_sared_preferences.dart';

class SharedPreferenceLogic{
  static Future<bool> isLogIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLogIn = pref.getBool(AppSharedPreference.isLogin);
    if (isLogIn == null) {
      pref.setBool(AppSharedPreference.isLogin, false);
      return false;
    } else {
      return isLogIn;
    }
  }

  static Future<void> setLoginFalse() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLogIn = pref.getBool(AppSharedPreference.isLogin);
    if (isLogIn == null) {
      pref.setBool(AppSharedPreference.isLogin, false);
    } else {
      pref.setBool(AppSharedPreference.isLogin, false);
    }
  }

  static Future<void> setLoginTrue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLogIn = pref.getBool(AppSharedPreference.isLogin);
    if (isLogIn == null) {
      pref.setBool(AppSharedPreference.isLogin, true);
    } else {
      pref.setBool(AppSharedPreference.isLogin, true);
    }
  }

  static Future<void> saveCounter({required int counter}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(AppSharedPreference.counter, counter);
  }

  static Future<void> removeCounter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(AppSharedPreference.counter, 0);
  }

  static Future<int> getCounter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? counter = pref.getInt(AppSharedPreference.counter);
    if (counter == null) {
      pref.setInt(AppSharedPreference.counter, 0);
      return 0;
    } else {
      return counter;
    }
  }
}