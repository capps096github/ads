// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'ad_helper.dart';


// class InterstitialAdsProvider with ChangeNotifier {
//   InterstitialAd? _interstitialAd;

//   int _adViewCount = 1;
//   get adViewCount => _adViewCount;

//   void _increment() {
//     _adViewCount += 1;
//     notifyListeners();
//   }

//   void initAd() {
//     print('Ad Initialising....' * 5);
//     _interstitialAd = InterstitialAd(
//       adUnitId: AdHelper.interstitialAdUnitId,
//       listener: _onInterstitialAdEvent,
//     );

//     _loadInterstitialAd();
//   }

//    void _loadInterstitialAd(BuildContext context) {
//     InterstitialAd.load(
//       adUnitId: AdHelper.interstitialAdUnitId,
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) {
//           this._interstitialAd = ad;

//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (ad) {
//                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
//             },
//           );

//           _isInterstitialAdReady = true;
//         },
//         onAdFailedToLoad: (err) {
//           print('Failed to load an interstitial ad: ${err.message}');
//           _isInterstitialAdReady = false;
//         },
//       ),
//     );
//   }


//   void disposeAd() {
//     _interstitialAd?.dispose();
//   }

//   bool _isInterstitialAdReady = false;

//   bool get isInterstitialAdReady => _isInterstitialAdReady;



//   Future<void> showAd() {
//    if (_isInterstitialAdReady) {
//                 _interstitialAd?.show();
//               } else {
//                 _moveToHome();
//               }
//   }

// }


