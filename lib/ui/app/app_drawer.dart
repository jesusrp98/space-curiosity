import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../general/list_cell.dart';
import '../general/separator.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListCell(
            leading: const Icon(
              FontAwesomeIcons.rocket,
              size: 42,
            ),
            title: FlutterI18n.translate(
              context,
              'home.page.menu.spacex.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'home.page.menu.spacex.body',
            ),
            onTap: () => openPage(context, '/spacex'),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: Icon(
              Icons.description,
              size: 42,
            ),
            title: FlutterI18n.translate(
              context,
              'home.page.menu.news.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'home.page.menu.news.body',
            ),
            onTap: () => openPage(context, '/news'),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.public, size: 42),
            title: FlutterI18n.translate(
              context,
              'home.page.menu.planets.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'home.page.menu.planets.body',
            ),
            onTap: () => openPage(context, '/planets'),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.my_location, size: 42),
            title: FlutterI18n.translate(
              context,
              'home.page.menu.iss.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'home.page.menu.iss.body',
            ),
            onTap: () => openPage(context, '/iss'),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(
              Icons.fitness_center,
              size: 42,
            ),
            title: FlutterI18n.translate(
              context,
              'home.page.menu.weight.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'home.page.menu.weight.body',
            ),
            onTap: () => openPage(context, '/weight'),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.camera_alt, size: 42),
            title: FlutterI18n.translate(
              context,
              'home.page.menu.mars.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'home.page.menu.mars.body',
            ),
            onTap: () => openPage(context, '/mars'),
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
