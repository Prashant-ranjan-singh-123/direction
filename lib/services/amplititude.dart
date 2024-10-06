

import 'dart:developer';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:direction/services/my_app_firebase_analytics/AnalyticsEngine.dart';

import '../utils/userIdGenerator.dart';

class MyAppAmplitudeAndFirebaseAnalitics {
  MyAppAmplitudeAndFirebaseAnalitics._privateConstructor();

  static MyAppAmplitudeAndFirebaseAnalitics instanse(){
    return MyAppAmplitudeAndFirebaseAnalitics._privateConstructor();
  }

  Future<void> logEvent({required String event}) async {
    // Amplitude Event
    try {
      final Amplitude analytics = Amplitude.getInstance(
          instanceName: "default");
      analytics.init("2e61ff14942687a0ea478d42d70c6276");

      // Optionally set the user ID.
      var userId = await AmplititudeUserId.instance().getUserId();
      analytics.setUserId(userId);

      // Log an event
      analytics.logEvent(event);

      print('${event} event logged successfully.');
    } catch (e){
      log('Error Occur while taking response (amplititude)');
    }

    try{
      AnalyticsEngine.instace.logFirebaseEvent(FirebaseEventName: event);
    }catch (e){
      log('Error while logging firebase event');
    }
  }
}