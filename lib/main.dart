import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:space_news/data/models/theme/theme.dart';

import 'data/models/planets/celestial_body.dart';
import 'ui/about.dart';
import 'ui/calculator/screen.dart';
import 'ui/home.dart';
import 'ui/iss/screen.dart';
import 'ui/news/screen.dart';
import 'ui/planets/details/edit.dart';
import 'ui/planets/screen.dart';
import 'ui/settings.dart';
import 'ui/spacex/start.dart';
import 'util/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider.value(value: ThemeModel()..init()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, model, child) => MaterialApp(
              title: 'Space Curiosity',
              theme: model.lightTheme,
              darkTheme: model.darkTheme,
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
                FlutterI18nDelegate(
                  useCountryCode: false,
                  fallbackFile: 'en',
                ),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
            ),
      ),
    );
  }
}
