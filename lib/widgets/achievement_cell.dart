import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:space_news/util/colors.dart';

class AchievementCell extends StatelessWidget {
  final String title, subtitle, date, url;
  final int index;

  AchievementCell({
    this.title,
    this.subtitle,
    this.date,
    this.url,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.white,
        child: Text(
          '#$index',
          style:
              Theme.of(context).textTheme.subhead.copyWith(color: Colors.black),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.subhead.copyWith(
                  color: primaryColor,
                ),
          ),
          Container(height: 8.0),
        ],
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.justify,
        style:
            Theme.of(context).textTheme.subhead.copyWith(color: secondaryText),
      ),
      onTap: () async => await FlutterWebBrowser.openWebPage(
            url: url,
            androidToolbarColor: primaryColor,
          ),
    );
  }
}
