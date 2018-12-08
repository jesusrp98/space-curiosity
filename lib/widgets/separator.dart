import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final Widget body;

  Separator(this.body);

  @override
  Widget build(BuildContext context) {
    return body;
  }

  factory Separator.spacer() {
    return Separator(SizedBox(height: 12.0));
  }

  factory Separator.cardSpacer() {
    return Separator(SizedBox(height: 8.0));
  }

  factory Separator.divider({double indent = 0.0}) {
    return Separator(Divider(height: 24, indent: indent));
  }

  factory Separator.none() {
    return Separator(Container());
  }
}
