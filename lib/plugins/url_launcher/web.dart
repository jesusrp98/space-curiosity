import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class UrlUtils {
  UrlUtils._();

  static void open({
    String url,
    Color androidToolbarColor,
  }) {
    html.window.open(url, 'Info');
  }
}
