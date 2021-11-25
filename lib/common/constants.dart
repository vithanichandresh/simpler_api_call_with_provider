import 'dart:io';

class Constants {
  static const BASE_URL = 'https://run.mocky.io/v3/';
  static const PREF_BOOK = 'book';
  static Future<bool> isInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

}
