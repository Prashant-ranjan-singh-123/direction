import 'package:url_launcher/url_launcher.dart';

class AppOpener {

  // Launches a URL
  static Future<void> launchAppUsingUrl({required String link}) async {
    final Uri _url = Uri.parse(link);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
