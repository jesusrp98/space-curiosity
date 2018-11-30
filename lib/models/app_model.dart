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

  ThemeData buildThemeData() => ThemeData(
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

  void changeTheme(BuildContext context, {@required Themes theme}) {
    switch (theme) {
      case Themes.light:
        changeBrightness(context, dark: false);
        changeColor(context,
            primaryColor: Colors.blue,
            accentColor: Colors.red,
            scaffoldBackgroundColor: Colors.white);
        break;
      case Themes.black:
        changeBrightness(context, dark: true);
        changeColor(context,
            primaryColor: Colors.blue,
            accentColor: Colors.red,
            scaffoldBackgroundColor: Colors.black);
        break;
      case Themes.dark:
        changeBrightness(context, dark: true);
        changeColor(context,
            primaryColor: Colors.blue,
            accentColor: Colors.red,
            scaffoldBackgroundColor: Colors.grey);
        break;
      default:
    }
  }

  void changeBrightness(BuildContext context, {bool dark = false}) {
    if (dark) {
      DynamicTheme.of(context).setBrightness(Brightness.dark);
    } else {
      DynamicTheme.of(context).setBrightness(Brightness.light);
    }
  }

  void changeColor(
    BuildContext context, {
    @required Color primaryColor,
    Color accentColor,
    Color scaffoldBackgroundColor,
  }) {
    DynamicTheme.of(context).setThemeData(new ThemeData(
      primaryColor: primaryColor,
      accentColor: accentColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
    ));
  }
}
