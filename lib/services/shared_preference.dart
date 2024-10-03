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
    String? countryCode = pref.getString(AppSharedPreference.countryCodeString);
    if(countryCode==null){
      print('Cant save token because country code is not available');
    }else if(countryCode=='IN'){
      pref.setInt(AppSharedPreference.counterIn, counter);
    }else{
      pref.setInt(AppSharedPreference.counterNotIn, counter);
    }
  }

  static Future<void> saveCountryCode({required String countryCodeString}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppSharedPreference.countryCodeString, countryCodeString);
  }

  static Future<String> getCountryCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? counter = pref.getString(AppSharedPreference.countryCodeString);
    if (counter == null) {
      return '';
    } else {
      return counter;
    }
  }

  static Future<int> getCounter({required bool isIn}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? counter;
    if(isIn) {
      counter = pref.getInt(AppSharedPreference.counterIn);
    }else{
      counter = pref.getInt(AppSharedPreference.counterNotIn);
    }
    if (counter == null) {
      pref.setInt(AppSharedPreference.counterIn, 0);
      pref.setInt(AppSharedPreference.counterNotIn, 0);
      return 0;
    } else {
      return counter;
    }
  }

  static Future<bool> isfreshInstall() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isfreshInstal = pref.getBool(AppSharedPreference.firstInstall);

    if(isfreshInstal==null){
      await pref.setBool(AppSharedPreference.firstInstall, false);
      return true;
    } else if(isfreshInstal){
      await pref.setBool(AppSharedPreference.firstInstall, false);
      return true;
    }else{
      await pref.setBool(AppSharedPreference.firstInstall, false);
      return true;
    }
  }
}