 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



  final adsProvider = FutureProvider<InitializationStatus>((ref) async {
  return await MobileAds.instance.initialize();
});