import 'dart:math';

import 'package:direction/services/shared_preference.dart';
import 'package:direction/utils/app_sared_preferences.dart';

class AmplititudeUserId {

  AmplititudeUserId._();

  static AmplititudeUserId instance(){
    return AmplititudeUserId._();
  }

  static String generateRandomString({required int len}) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Future<String> getUserId() async {
    return SharedPreferenceLogic.getAmplititudeUserId();
  }
}
