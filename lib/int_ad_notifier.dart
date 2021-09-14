// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



class InterstialAdNotifier extends ChangeNotifier {
  InterstitialAd? _interstitialAd;

  bool isInterstitialAdReady = false;

  // bool get isInterstitialAdReady => isInterstitialAdReady;

  void updateAdStatus(bool isAdReady) {
    isInterstitialAdReady = isAdReady;
    print("\n\n\n\nAd loaded == $isInterstitialAdReady\n\n\n\n");

    notifyListeners();
  }

  void loadInterstitialAd() async {
    print("Loadign ad InterstitialAd.testAdUnitId\n" * 100);
    await InterstitialAd.load(
      // TODO place here the actual ad unit
      // adUnitId: AdHelper.interstitialAdUnitId,
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("Loaded ad InterstitialAd.testAdUnitId\n" * 100);
          // this.isInterstitialAdReady = true;
          updateAdStatus(true);

          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print("Close");

              // this.isInterstitialAdReady = false;
              // notifyListeners();
            },
          );
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');

          // isInterstitialAdReady = false;
          // notifyListeners();
        },
      ),
    );

    notifyListeners();
  }

  void showAd() {
    if (isInterstitialAdReady) {
      _interstitialAd?.show();
      loadInterstitialAd();
    } else {
      print('Failed to load an interstitial ad: ');
      loadInterstitialAd();
      // _moveToHome();
    }
  }

  void disposeAd() {
    _interstitialAd?.dispose();
  }
}
