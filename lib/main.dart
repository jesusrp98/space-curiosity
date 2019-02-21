import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'bloc/delegate.dart';
import 'models/app_model.dart';
import 'models/planets/celestial_body.dart';
import 'ui/about.dart';
import 'ui/home.dart';
import 'ui/iss/screen.dart';
import 'ui/news/screen.dart';
import 'ui/planets/details/edit.dart';
import 'ui/planets/screen.dart';
import 'ui/settings.dart';
import 'ui/spacex/screen.dart';

final AppModel model = AppModel();

void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  model.loadTheme();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: model,
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => MaterialApp(
              title: 'Space Curiosity',
              theme: model.themeData,
              home: HomeScreen(),
              debugShowCheckedModeBanner: false,
              routes: <String, WidgetBuilder>{
                '/home': (_) => HomeScreen(),
                '/spacex': (_) => SpaceXScreen(),
                '/news': (_) => ArticlesScreen(),
                '/planets': (_) => SolarSystemScreen(planetModel: PlanetsModel(),),
                '/iss': (_) => IssScreen(),
                '/info': (_) => AboutScreen(),
                '/about': (_) => AboutScreen(),
                AddEditPlanetPage.routeName: (_) =>
                    AddEditPlanetPage(null, type: BodyType.planet),
                '/settings': (_) => SettingsScreen(),
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
