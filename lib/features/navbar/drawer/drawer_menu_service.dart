import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DrawerMenuService {
  static Future<void> shareApp() async {
    await Share.share("Check out Dash TV! Download now. 🔥");
  }

  static void shareMovie(int movieId) {
    final link = "dashtv://movie/$movieId";
    Share.share("Watch this movie on Dash TV:\n$link");
  }

  static Future<void> sendFeedback() async {
    final Uri email = Uri(
      scheme: "mailto",
      path: "support@dashtv.com",
      query: "subject=Feedback for Dash TV App",
    );
    await launchUrl(email);
  }

  static Future<void> rateApp() async {
    const url = "https://play.google.com/store/apps/details?id=com.dashtv.app";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> contactSupport() async {
    const whatsapp = "https://wa.me/+919714661972";
    await launchUrl(Uri.parse(whatsapp), mode: LaunchMode.externalApplication);
  }

  static Future<void> moreOptions() async {
    debugPrint("Open settings or more options...");
    // Extend later (Settings page, About page, etc.)
  }
}
