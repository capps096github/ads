// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import 'package:admob_inline_ads_in_flutter/destination.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';

class NativeInlinePage extends StatefulWidget {
  final List<Destination> entries;

  NativeInlinePage({
    required this.entries,
  });

  @override
  State createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  static final _kAdIndex = 4;

  late NativeAd _ad;

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
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'nativeAd',
      request: AdRequest(),
      listener: NativeAdListener(
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
        title: Text('AdMob Native Inline Ad'),
      ),
      body: ListView.builder(
        itemCount: widget.entries.length + (_isAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          if (_isAdLoaded && index == _kAdIndex) {
            return Container(
              padding: EdgeInsets.all(4),
              child: AdWidget(ad: _ad),
              height: 400,
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
        },
      ),
    );
  }

  @override
  void dispose() {
    _ad.dispose();

    super.dispose();
  }
}
