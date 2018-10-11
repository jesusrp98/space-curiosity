import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget screen;

  HomeIcon({this.icon, this.title, this.screen});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(16.0),
      onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen, fullscreenDialog: true),
          ),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 36.0),
          Container(height: 8.0),
          Text(title, style: Theme.of(context).textTheme.subhead),
        ],
      ),
    );
  }
}
