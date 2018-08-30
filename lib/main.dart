import 'package:flutter/material.dart';

import 'screens/bottom_navigation.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple counters',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BottomNavigation(),
    );
  }
}
