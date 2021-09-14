
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';
import 'destination.dart';

class BannerInlinePage extends StatefulWidget {
  final List<Destination> entries;

  BannerInlinePage({
    required this.entries,
  });

  @override
  State createState() => _BannerInlinePageState();
}

class _BannerInlinePageState extends State<BannerInlinePage> {
  static final _kAdIndex = 4;

  late BannerAd _ad;

  bool _isAdLoaded = false;

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Banner Inline Ad'),
      ),
      body: ListView.builder(
          itemCount: widget.entries.length + (_isAdLoaded ? 1 : 0),
          itemBuilder: (context, index) {
            if (_isAdLoaded && index == _kAdIndex) {
              return Container(
                child: AdWidget(ad: _ad),
                width: _ad.size.width.toDouble(),
                height: 72.0,
                alignment: Alignment.center,
              );
            } else {
              final item = widget.entries[_getDestinationItemIndex(index)];

              return ListTile(
                leading: Image.asset(
                  item.asset,
                  width: 48,
                  height: 48,
                  package: 'flutter_gallery_assets',
                  fit: BoxFit.cover,
                ),
                title: Text(item.name),
                subtitle: Text(item.duration),
                onTap: () {
                  print('Clicked ${item.name}');
                },
              );
            }
          }),
    );
  }

  @override
  void dispose() {
_ad.dispose();

    super.dispose();
  }


}
