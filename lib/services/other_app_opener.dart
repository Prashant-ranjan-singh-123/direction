import 'package:url_launcher/url_launcher.dart';

class AppOpener {
  // Launches a URL
  static Future<void> launchAppUsingUrl({required String link}) async {
    final Uri _url = Uri.parse(link);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Launches a URL
  static Future<void> launchPrivacyPolicy() async {
    final Uri _url = Uri.parse(
        'https://berry-yacht-fe8.notion.site/Direction-Private-Policy-417a2910f97141538baf27be219cbf0c');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
