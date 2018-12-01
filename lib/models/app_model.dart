import 'package:scoped_model/scoped_model.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import '../util/colors.dart';

enum Themes { light, dark, black }

class AppModel extends Model {
  Themes _currentTheme = Themes.dark;
  Brightness defaultBrigthness = Brightness.dark;

  get theme => _currentTheme;

  set theme(Themes newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }

  ThemeData _themeData = new ThemeData(
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

  get themeData => _themeData;

  set themeData(Themes newTheme) {
    switch (newTheme) {
      case Themes.light:
        // _themeData = new ThemeData(
        //   brightness: Brightness.dark,
        //   fontFamily: 'ProductSans',
        //   primaryColor: primaryColor,
        //   accentColor: accentColor,
        //   canvasColor: backgroundColor,
        //   cardColor: cardColor,
        //   dialogBackgroundColor: cardColor,
        //   dividerColor: dividerColor,
        //   highlightColor: highlightColor,
        // );
        _themeData = ThemeData.light();
        break;
      case Themes.dark:
      case Themes.black:
        // _themeData = new ThemeData(
        //   brightness: Brightness.dark,
        //   fontFamily: 'ProductSans',
        //   primaryColor: primaryColor,
        //   accentColor: accentColor,
        //   canvasColor: backgroundColor,
        //   cardColor: cardColor,
        //   dialogBackgroundColor: cardColor,
        //   dividerColor: dividerColor,
        //   highlightColor: highlightColor,
        // );
        _themeData = ThemeData.dark();
        break;
      default:
    }
    notifyListeners();
  }
}
