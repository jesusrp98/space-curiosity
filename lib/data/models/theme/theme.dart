import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../../../util/colors.dart';

class ThemeModel extends ChangeNotifier {
  static const _darkModeKey = 'dark-mode';
  static const _useSystemModeKey = 'system-mode';
  final _storage = LocalStorage('theme-settings');
  bool _darkMode = true;
  bool get darkMode => _darkMode;
  bool get _defaultSystemSetting => Platform.isIOS ? false : true;
  bool _useSystemSetting = true;
  bool get useSystemSetting => _useSystemSetting;

  void init() async {
    await _storage.ready;
    _darkMode = _storage.getItem(_darkModeKey) ?? true;
    _useSystemSetting = _storage.getItem(_useSystemModeKey) ?? _defaultSystemSetting;
    notifyListeners();
  }

  void changeBrightnessDark(bool value) {
    _darkMode = value;
    notifyListeners();
    _storage.setItem(_darkModeKey, value);
  }

  void changeSystemDark(bool value) {
    _useSystemSetting = value;
    notifyListeners();
    _storage.setItem(_useSystemModeKey, value);
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;

  ThemeData get lightTheme =>
      !_useSystemSetting && _darkMode ? _darkThemeData : _lightThemeData;
  ThemeData get darkTheme => !_useSystemSetting ? null : _darkThemeData;

  final _lightThemeData = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'ProductSans',
    primaryColor: lightPrimaryColor,
    accentColor: lightAccentColor,
  );
  final _darkThemeData = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'ProductSans',
    primaryColor: darkPrimaryColor,
    accentColor: darkAccentColor,
    canvasColor: darkCanvasColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
    dialogBackgroundColor: darkCardColor,
  );
}
