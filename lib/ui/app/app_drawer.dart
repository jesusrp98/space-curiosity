import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Space Curiosity'),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rocket),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.spacex.title',
            )),
            onTap: () => openPage(context, '/spacex'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.news.title',
            )),
            onTap: () => openPage(context, '/news'),
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.planets.title',
            )),
            onTap: () => openPage(context, '/planets'),
          ),
          ListTile(
            leading: const Icon(Icons.my_location),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.iss.title',
            )),
            onTap: () => openPage(context, '/iss'),
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text(FlutterI18n.translate(
              context,
              'home.page.menu.weight.title',
            )),
            onTap: () => openPage(context, '/weight'),
          ),
          // Separator.divider(height: 0.0, indent: 74.0),
          // ListTile(
          //   leading: const Icon(Icons.camera_alt, size: 42),
          //   title: Text(FlutterI18n.translate(
          //     context,
          //     'home.page.menu.mars.title',
          //   )),
          //   onTap: () => openPage(context, '/mars'),
          // ),
        ],
      ),
    );
  }

  openPage(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }
}
