import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/colors.dart';

enum Themes { light, dark, black }

class AppModel extends Model {
  Themes _currentTheme = Themes.dark;

  get theme => _currentTheme;

  set theme(Themes newTheme) {
    if (newTheme != null) {
      _currentTheme = newTheme;
      themeData = newTheme;
      notifyListeners();
    }
  }

  ThemeData _themeData = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'ProductSans',
    primaryColor: darkPrimaryColor,
    accentColor: darkAccentColor,
    canvasColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
  );

  get themeData => _themeData;

  set themeData(Themes newTheme) {
    switch (newTheme) {
      case Themes.light:
        _themeData = ThemeData.light().copyWith(
          brightness: Brightness.light,
          // fontFamily: 'ProductSans',
          primaryColor: lightPrimaryColor,
          accentColor: lightAccentColor,
          dividerColor: lightDividerColor,
        );
        break;
      case Themes.dark:
        _themeData = ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          // fontFamily: 'ProductSans',
          primaryColor: darkPrimaryColor,
          accentColor: darkAccentColor,
          canvasColor: darkBackgroundColor,
          scaffoldBackgroundColor: darkBackgroundColor,
          cardColor: darkCardColor,
          dividerColor: darkDividerColor,
        );
        break;
      case Themes.black:
        _themeData = ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          // fontFamily: 'ProductSans',
          primaryColor: blackPrimaryColor,
          accentColor: blackAccentColor,
          canvasColor: blackBackgroundColor,
          scaffoldBackgroundColor: blackBackgroundColor,
          cardColor: blackCardColor,
          dividerColor: blackDividerColor,
        );
        break;
      default:
    }
    notifyListeners();
  }

  Future loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var _savedTheme = prefs.getString("theme");

      if (_savedTheme.contains('light')) {
        theme = Themes.light;
      } else if (_savedTheme.contains('dark')) {
        theme = Themes.dark;
      } else if (_savedTheme.contains('black')) {
        theme = Themes.black;
      } else {
        theme = Themes.dark;
      }
    } catch (e) {
      print(e);
      theme = Themes.dark;
      prefs.setString('theme', 'dark');
    }
    notifyListeners();
  }
}
