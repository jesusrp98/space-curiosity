import 'package:flutter/material.dart';

import '../util/colors.dart';

class SpacexHomeDetail extends StatelessWidget {
  final IconData icon;
  final String body;

  SpacexHomeDetail(this.icon, this.body);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Icon(icon, size: 42.0),
      title: Text(
        body,
        style:
            Theme.of(context).textTheme.subhead.copyWith(color: secondaryText),
      ),
    );
  }
}
