import 'package:flutter/material.dart';

import 'models/planets/celestial_body.dart';
import 'screens/bottom_navigation.dart';
import 'screens/tabs/nasa/home_page.dart';
import 'screens/tabs/news.dart';
import 'screens/tabs/planets/add_edit_planet.dart';
import 'screens/tabs/planets/planets.dart';
import 'screens/tabs/space_x/home_page.dart';
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
        routes: <String, WidgetBuilder>{
          "/home": (BuildContext context) => BottomNavigation(),
          "/space_x": (BuildContext context) => SpaceXHomePage(),
          "/nasa": (BuildContext context) => NasaHomePage(),
          "/news": (BuildContext context) => NewsHomePage(),
          "/planets": (BuildContext context) => PlanetsHomePage(),
          AddEditPlanetPage.routeName: (BuildContext context) =>
              AddEditPlanetPage(
                null,
                type: BodyType.planet,
              ),
        });
  }
}
