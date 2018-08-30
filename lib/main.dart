import 'package:flutter/material.dart';

import 'screens/bottom_navigation.dart';
import 'util/colors.dart';
import 'util/localization.dart';

void main() => runApp(MyApp());

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
      title: ScopedModelLocalizations().appTitle,
      theme: _buildThemeData(),
      home: BottomNavigation(),
      localizationsDelegates: [
        ScopedModelLocalizationsDelegate(),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
