import 'package:flutter/material.dart';

import 'models/planets/celestial_body.dart';
import 'screens/home_screen.dart';
import 'screens/tabs/news_screen.dart';
import 'screens/tabs/planets/add_edit_planet.dart';
import 'screens/tabs/planets/planets.dart';
import 'screens/tabs/space_x/spacex_screen.dart';
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
      home: HomeScreen(),
      localizationsDelegates: [ScopedModelLocalizationsDelegate()],
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (_) => HomeScreen(),
        '/space_x': (_) => SpacexScreen(),
        '/news': (_) => NewsScreen(),
        '/planets': (_) => PlanetsTab(),
        AddEditPlanetPage.routeName: (_) =>
            AddEditPlanetPage(null, type: BodyType.planet),
      },
    );
  }
}
