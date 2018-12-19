import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/app_model.dart';
import 'models/planets/celestial_body.dart';
import 'screens/screen_about.dart';
import 'screens/screen_home.dart';
import 'screens/settings.dart';
import 'screens/tabs/iss/screen_iss.dart';
import 'screens/tabs/news/screen_news.dart';
import 'screens/tabs/planets/add_edit_planet.dart';
import 'screens/tabs/planets/screen_solar_system.dart';
import 'screens/tabs/space_x/screen_spacex.dart';

final AppModel model = AppModel();

void main() async {
  model.loadTheme();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<AppModel>(
        model: model,
        child: new ScopedModelDescendant<AppModel>(
          builder: (context, child, model) => MaterialApp(
                title: 'Space Curiosity',
                theme: model.themeData,
                home: HomeScreen(),
                debugShowCheckedModeBanner: false,
                routes: <String, WidgetBuilder>{
                  '/home': (_) => HomeScreen(),
                  '/spacex': (_) => SpacexScreen(),
                  '/news': (_) => NewsScreen(),
                  '/planets': (_) => SolarSystemScreen(),
                  '/iss': (_) => IssScreen(),
                  '/info': (_) => AboutScreen(),
                  AddEditPlanetPage.routeName: (_) =>
                      AddEditPlanetPage(null, type: BodyType.planet),
                  '/settings': (_) => SettingsPage(),
                },
                localizationsDelegates: [
                  FlutterI18nDelegate(false, 'en'),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
              ),
        ));
  }
}
