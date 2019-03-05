import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/bloc/bloc.dart';
import 'data/bloc/delegate.dart';
import 'data/models/planets/celestial_body.dart';
import 'ui/about.dart';
import 'ui/calculator/screen.dart';
import 'ui/home.dart';
import 'ui/iss/screen.dart';
import 'ui/news/screen.dart';
import 'ui/planets/details/edit.dart';
import 'ui/planets/screen.dart';
import 'ui/settings.dart';
import 'ui/spacex/screen.dart';
import 'util/colors.dart';

final ThemeModel _theme = ThemeModel(
  type: ThemeType.dark,
  customLightTheme: ThemeData(
    brightness: Brightness.light,
    fontFamily: 'ProductSans',
    primaryColor: lightPrimaryColor,
    accentColor: lightAccentColor,
    dividerColor: lightDividerColor,
  ),
  customDarkTheme: ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'ProductSans',
    primaryColor: darkPrimaryColor,
    accentColor: darkAccentColor,
    canvasColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
  ),
  customBlackTheme: ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'ProductSans',
    primaryColor: blackPrimaryColor,
    accentColor: blackAccentColor,
    canvasColor: blackBackgroundColor,
    scaffoldBackgroundColor: blackBackgroundColor,
    cardColor: blackCardColor,
    dividerColor: blackDividerColor,
  ),
  customCustomTheme: ThemeData(
    brightness: Brightness.light,
    fontFamily: 'ProductSans',
    primaryColor: lightPrimaryColor,
    accentColor: lightAccentColor,
    dividerColor: lightDividerColor,
  ),
);

void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
      model: _theme,
      child: new ScopedModelDescendant<ThemeModel>(
          builder: (context, child, theme) => MaterialApp(
                title: 'Space Curiosity',
                theme: theme.theme,
                home: HomeScreen(),
                debugShowCheckedModeBanner: false,
                routes: <String, WidgetBuilder>{
                  '/home': (_) => HomeScreen(),
                  '/spacex': (_) => SpaceXScreen(),
                  '/news': (_) => ArticlesScreen(),
                  '/planets': (_) =>
                      SolarSystemScreen(planetModel: PlanetsModel()),
                  '/iss': (_) => IssScreen(),
                  '/info': (_) => AboutScreen(),
                  '/about': (_) => AboutScreen(),
                  '/weight': (_) => CalculatorScreen(),
                  AddEditPlanetPage.routeName: (_) =>
                      AddEditPlanetPage(null, type: BodyType.planet),
                  '/settings': (_) => SettingsScreen(),
                },
                localizationsDelegates: [
                  FlutterI18nDelegate(false, 'en'),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
              )),
    );
  }
}
