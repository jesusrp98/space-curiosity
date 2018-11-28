import 'package:flutter/material.dart';

class HomeSheet extends StatelessWidget {
  final Widget body;

  HomeSheet(this.body);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.expand_more,
            size: 24.0,
          ),
        ),
        const Divider(height: 0.0),
        body,
      ],
    );
  }
}
