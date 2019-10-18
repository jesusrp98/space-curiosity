import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter/material.dart';

class UrlUtils {
  UrlUtils._();

  static void open({
    String url,
    Color androidToolbarColor,
  }) async {
    FlutterWebBrowser.openWebPage(
      url: url,
      androidToolbarColor: androidToolbarColor,
    );
  }
}
