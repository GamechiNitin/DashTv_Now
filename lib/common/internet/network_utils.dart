import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkUtils {
  static Future<bool> checkInternet() async {
    try {
      return await InternetConnection().hasInternetAccess;
    } catch (_) {
      return false;
    }
  }
}
