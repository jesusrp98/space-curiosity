import 'package:flutter/material.dart';

class SolarSystemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Solar System'),
        centerTitle: true,
      ),
      body: const Text("I'm a screen: wooh!"),
    );
  }
}
