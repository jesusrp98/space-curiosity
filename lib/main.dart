import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/planets/celestial_body.dart';
import 'screens/screen_home.dart';
import 'screens/tabs/news/screen_news.dart';
import 'screens/tabs/planets/add_edit_planet.dart';
import 'screens/tabs/planets/screen_solar_system.dart';
import 'screens/tabs/space_x/screen_spacex.dart';
import 'util/colors.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/app_model.dart';
import 'screens/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<AppModel>(
      model: AppModel(),
      child: new ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => 
               MaterialApp(
                title: 'Space Curiosity',
                theme: model.themeData,
                home: HomeScreen(),
                debugShowCheckedModeBanner: false,
                routes: <String, WidgetBuilder>{
                  '/home': (_) => HomeScreen(),
                  '/space_x': (_) => SpacexScreen(),
                  '/news': (_) => NewsScreen(),
                  '/planets': (_) => SolarSystemScreen(),
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
            
      ),
    );
  }
}
