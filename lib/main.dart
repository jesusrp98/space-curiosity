import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/planets/celestial_body.dart';
import 'screens/screen_about.dart';
import 'screens/screen_home.dart';
import 'screens/tabs/iss/screen_iss.dart';
import 'screens/tabs/news/screen_news.dart';
import 'screens/tabs/planets/add_edit_planet.dart';
import 'screens/tabs/planets/screen_solar_system.dart';
import 'screens/tabs/space_x/screen_spacex.dart';
import 'util/colors.dart';

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
      title: 'Space Curiosity',
      theme: _buildThemeData(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (_) => HomeScreen(),
        '/spacex': (_) => SpacexScreen(),
        '/news': (_) => NewsScreen(),
        '/planets': (_) => SolarSystemScreen(),
        '/iss': (_) => IssScreen(),
        '/info': (_) => AboutScreen(),
        '/settings': (_) => AboutScreen(),
        AddEditPlanetPage.routeName: (_) =>
            AddEditPlanetPage(null, type: BodyType.planet),
      },
      localizationsDelegates: [
        FlutterI18nDelegate(false, 'en'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
