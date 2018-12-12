import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final Widget body;

  Separator(this.body);

  @override
  Widget build(BuildContext context) {
    return body;
  }

  factory Separator.spacer({double height = 12.0, double width = 0.0}) {
    return Separator(SizedBox(height: height, width: width));
  }

  factory Separator.cardSpacer() {
    return Separator(SizedBox(height: 8.0));
  }

  factory Separator.divider({double height = 24.0, double indent = 0.0}) {
    return Separator(Divider(height: height, indent: indent));
  }

  factory Separator.none() {
    return Separator(Container());
  }
}
