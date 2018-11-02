import 'package:flutter/material.dart';

import '../util/colors.dart';

class SpacexHomeDetail extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;

  SpacexHomeDetail({this.icon, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Icon(icon, size: 42.0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Container(height: 6.0),
        ],
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.justify,
        style:
            Theme.of(context).textTheme.subhead.copyWith(color: secondaryText),
      ),
    );
  }
}
