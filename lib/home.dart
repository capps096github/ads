import 'package:admob_inline_ads_in_flutter/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';
import 'calcut_ads_riverpod.dart';
import 'int_ad_notifier.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final ad = watch(adsProvider);

    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: ad.when(
        data: (InitializationStatus initializationStatus) {
          return HomeAd();
        },
        loading: () => Container(
          color: Colors.blue,
        ),
        error: (err, stacjk) => Container(
          color: Colors.red,
          child: Text(err.toString()),
        ),
      ),
    );
  }
}

final InterstialAdNotifier intAdNotifier = InterstialAdNotifier();

class HomeAd extends StatefulWidget {
  const HomeAd({
    Key? key,
  }) : super(key: key);

  @override
  _HomeAdState createState() => _HomeAdState();
}

class _HomeAdState extends State<HomeAd> {
  @override
  void initState() {
    intAdNotifier.loadInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Btn(),
    );
  }

  // InterstitialAd? _interstitialAd;

  // bool _isInterstitialAdReady = false;

  // void _loadInterstitialAd() async {
  //   print("Loadign ad InterstitialAd.testAdUnitId");
  //   await InterstitialAd.load(
  //     // adUnitId: AdHelper.interstitialAdUnitId,
  //     adUnitId: InterstitialAd.testAdUnitId,
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         this._interstitialAd = ad;

  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //             // _moveToHome();
  //             print("Close");
  //             setState(() {
  //               _isInterstitialAdReady = false;
  //             });
  //             _loadInterstitialAd();
  //           },
  //         );
  //         setState(() {
  //           _isInterstitialAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load an interstitial ad: ${err.message}');
  //         // _isInterstitialAdReady = false;
  //         setState(() {
  //           _isInterstitialAdReady = false;
  //         });
  //       },
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   // COMPLETE: Dispose an InterstitialAd object
  //   _interstitialAd?.dispose();
  //   super.dispose();
  // }

  // void _moveToHome() {
  //   Navigator.of(context).pop();
  // }
}
