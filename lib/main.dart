import 'package:flutter/material.dart';

import 'models/planets/celestial_body.dart';
import 'screens/screen_home.dart';
import 'screens/tabs/news/screen_news.dart';
import 'screens/tabs/planets/add_edit_planet.dart';
import 'screens/tabs/planets/screen_solar_system.dart';
import 'screens/tabs/space_x/screen_spacex.dart';
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
        '/planets': (_) => SolarSystemScreen(),
        AddEditPlanetPage.routeName: (_) =>
            AddEditPlanetPage(null, type: BodyType.planet),
      },
    );
  }
}
