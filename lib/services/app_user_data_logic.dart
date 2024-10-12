import 'package:direction/services/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_sared_preferences.dart';
import '../utils/userIdGenerator.dart';

class AppUserDataLogic {
  static Future<void> save_email({required String email}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppSharedPreference.userEmail, email);
  }

  static Future<String?> get_email() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userEmail = pref.getString(AppSharedPreference.userEmail);
    if (userEmail == null) {
      return null;
    } else {
      return userEmail;
    }
  }

  static Future<void> remove_email() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppSharedPreference.userEmail);
  }

  static Future<void> save_name({required String name}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppSharedPreference.userDisplayName, name);
  }

  static Future<String?> get_name() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userDisplayName =
        pref.getString(AppSharedPreference.userDisplayName);
    if (userDisplayName == null) {
      return null;
    } else {
      return userDisplayName;
    }
  }

  static Future<void> remove_name() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppSharedPreference.userDisplayName);
  }

  static Future<void> save_image_url({required String image_url}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppSharedPreference.userPhotoURL, image_url);
  }

  static Future<String?> get_image_url() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userPhotoURL = pref.getString(AppSharedPreference.userPhotoURL);
    if (userPhotoURL == null) {
      return null;
    } else {
      return userPhotoURL;
    }
  }

  static Future<void> remove_image_url() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppSharedPreference.userPhotoURL);
  }

  static Future<void> save_user_uuid({required String user_uuid}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppSharedPreference.userUid, user_uuid);
  }

  static Future<String?> get_uuid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userUid = pref.getString(AppSharedPreference.userUid);
    if (userUid == null) {
      return null;
    } else {
      return userUid;
    }
  }

  static Future<void> remove_uuid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppSharedPreference.userUid);
  }

  static Future<void> sign_in(
      {required String name,
      required String image_url,
      required String uuid,
      required String email}) async {

    await Future.wait([
      save_email(email: email),
      save_image_url(image_url: image_url),
      save_name(name: name),
      save_user_uuid(user_uuid: uuid),
      SharedPreferenceLogic.setLoginTrue()
    ]);
  }

  static Future<void> log_out() async {
    await Future.wait([
      remove_email(),
      remove_image_url(),
      remove_name(),
      remove_uuid(),
      SharedPreferenceLogic.setLoginFalse()
    ]);
  }
}
