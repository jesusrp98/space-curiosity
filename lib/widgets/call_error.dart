import 'package:flutter/material.dart';

/// CALL ERROR WIDGET
/// Widget displayed when an error occurred presenting API data.
class CallError extends StatelessWidget {
  final VoidCallback onTap;

  CallError(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: onTap,
            iconSize: 64.0,
          ),
          Text(
            'No Items found\nTap to reload',
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
