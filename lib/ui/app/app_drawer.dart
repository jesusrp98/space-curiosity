import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../general/separator.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Row(children: <Widget>[
              SizedBox(
                height: 64,
                width: 64,
                child: Image.asset('assets/icons/android/playstore-icon.png'),
              ),
              Separator.spacer(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context, 'app.title'),
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Separator.spacer(height: 8),
                    Text(
                      FlutterI18n.translate(context, 'app.subtitle'),
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rocket),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.spacex',
            )),
            onTap: () => openPage(context, '/spacex'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.news',
            )),
            onTap: () => openPage(context, '/news'),
          ),
          ListTile(
            leading: const Icon(Icons.my_location),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.iss',
            )),
            onTap: () => openPage(context, '/iss'),
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.weight',
            )),
            onTap: () => openPage(context, '/weight'),
          ),
          Separator.divider(height: 16),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(FlutterI18n.translate(
              context,
              'home.menu.settings',
            )),
            onTap: () => openPage(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(FlutterI18n.translate(
              context,
              'home.menu.about',
            )),
            onTap: () => openPage(context, '/about'),
          ),
        ],
      ),
    );
  }

  openPage(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }
}
