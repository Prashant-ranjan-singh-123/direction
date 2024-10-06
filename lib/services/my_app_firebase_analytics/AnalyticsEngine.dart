import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  AnalyticsEngine._();

  static AnalyticsEngine instace = AnalyticsEngine._();

  final instance = FirebaseAnalytics.instance;

  Future<void> logFirebaseEvent({required String FirebaseEventName}) async {
    instance.setAnalyticsCollectionEnabled(true);
    await instance.logEvent(name: FirebaseEventName);
  }
}
