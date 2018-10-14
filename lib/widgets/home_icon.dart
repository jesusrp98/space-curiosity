import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final Widget leading, trailing;
  final String title, subtitle;
  final Widget screen;

  HomeIcon({
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      leading: leading,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
        ],
      ),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 16.0)),
      trailing: trailing,
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          ),
    );
  }
}
