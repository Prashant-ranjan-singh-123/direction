import 'package:amplitude_flutter/amplitude.dart';

class MyAppAmplitude {
  MyAppAmplitude._privateConstructor();

  static MyAppAmplitude instanse(){
    return MyAppAmplitude._privateConstructor();
  }

  Future<void> logEvent({required String event}) async {
    // Create Amplitude instance and pass the API key
    final Amplitude analytics = Amplitude.getInstance(instanceName: "default");
    analytics.init("2e61ff14942687a0ea478d42d70c6276");

    // Optionally set the user ID
    analytics.setUserId('abc123');

    // Log an event
    analytics.logEvent(event);

    print('${event} event logged successfully.');
  }
}
