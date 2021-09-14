import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'banner_inline_page.dart';
import 'destination.dart';
import 'home_page.dart';
import 'native_inline_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/banner': (context) => BannerInlinePage(entries: Destination.samples),
        '/native': (context) => NativeInlinePage(entries: Destination.samples),
      },
      home: HomePage(),
      // home: Home(),
    );
  }
}
