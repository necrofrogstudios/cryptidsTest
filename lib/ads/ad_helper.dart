import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1772118121041384/1269617005"; // CHANGE TO ca-app-pub-1772118121041384/1269617005 FOR GOOGLE PLAY PUBLISHING
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
