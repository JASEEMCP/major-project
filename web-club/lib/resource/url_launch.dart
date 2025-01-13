import 'package:url_launcher/url_launcher.dart';

Future openWeb(String? url) async {
  
  if (url == null) return;
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
  }
  // ignore: empty_catches
  catch (e) {}
}