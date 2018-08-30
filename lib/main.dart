import 'package:flutter/material.dart';

import 'screens/bottom_navigation.dart';
import 'utils/colors.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
   ThemeData _buildThemeData() => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'ProductSans',
        primaryColor: primaryColor,
        accentColor: accentColor,
        canvasColor: backgroundColor,
        cardColor: cardColor,
        dialogBackgroundColor: cardColor,
        dividerColor: dividerColor,
        highlightColor: highlightColor,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space News!',
      theme:  _buildThemeData(),
      home: BottomNavigation(),
    );
  }
}
