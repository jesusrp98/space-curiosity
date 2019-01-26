import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/colors.dart';

enum Themes { light, dark, black }

class AppModel extends Model {
  static final List<ThemeData> _themes = [
    ThemeData(
      brightness: Brightness.light,
      fontFamily: 'ProductSans',
      primaryColor: lightPrimaryColor,
      accentColor: lightAccentColor,
      dividerColor: lightDividerColor,
    ),
    ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'ProductSans',
      primaryColor: darkPrimaryColor,
      accentColor: darkAccentColor,
      canvasColor: darkBackgroundColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkCardColor,
      dividerColor: darkDividerColor,
    ),
    ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'ProductSans',
      primaryColor: blackPrimaryColor,
      accentColor: blackAccentColor,
      canvasColor: blackBackgroundColor,
      scaffoldBackgroundColor: blackBackgroundColor,
      cardColor: blackCardColor,
      dividerColor: blackDividerColor,
    )
  ];

  Themes _theme = Themes.dark;

  ThemeData _themeData = _themes[1];

  get theme => _theme;

  set theme(Themes newTheme) {
    if (newTheme != null) {
      _theme = newTheme;
      themeData = newTheme;
      notifyListeners();
    }
  }

  get themeData => _themeData;

  set themeData(Themes newTheme) {
    switch (newTheme) {
      case Themes.light:
        _themeData = _themes[0];
        break;
      case Themes.dark:
        _themeData = _themes[1];
        break;
      case Themes.black:
        _themeData = _themes[2];
        break;
      default:
        _themeData = _themes[1];
        break;
    }
    notifyListeners();
  }

  Future loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final String _savedTheme = prefs.getString('theme');

      if (_savedTheme.contains('light'))
        theme = Themes.light;
      else if (_savedTheme.contains('black'))
        theme = Themes.black;
      else
        theme = Themes.dark;
    } catch (e) {
      theme = Themes.dark;
      prefs.setString('theme', 'dark');
    }
    notifyListeners();
  }
}
