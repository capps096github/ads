import 'dart:io';

class CalcutAds {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_NATIVE_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_NATIVE_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}