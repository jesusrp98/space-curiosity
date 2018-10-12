import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final String title, subtitle;
  final Widget image;

  PhotoCard({this.title, this.subtitle, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: <Widget>[
          Expanded(child: image),
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Container(height: 8.0),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
