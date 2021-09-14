import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'int_ad_notifier.dart';

final interstitialAdNotifier =
    ChangeNotifierProvider<InterstialAdNotifier>((ref) {
  return InterstialAdNotifier();
});

class Btn extends StatelessWidget {
  const Btn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final interstitialAd = watch(interstitialAdNotifier);

        bool isAdAvailable = interstitialAd.isInterstitialAdReady;

        print("AddView = $isAdAvailable");

        return Center(
          child: isAdAvailable
              ? TextButton(
                  child: Text('close'.toUpperCase()),
                  onPressed: () {
                    interstitialAd.showAd();
                  },
                )
              : CircularProgressIndicator(),
        );
      },
    );
  }
}
