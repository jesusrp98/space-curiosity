import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';

import '../util/url.dart';
import 'general/list_cell.dart';
import 'general/separator.dart';

/// ABOUT SCREEN
/// This view contains a list with useful
/// information about the app & its developer.
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<Null> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'app.menu.about',
        )),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          ListCell(
            leading: const Icon(Icons.info_outline, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.version.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.version.body',
              {'version': _packageInfo.version, 'status': 'release'},
            ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.person_outline, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.author.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.author.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.authorReddit,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.star_border, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.review.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.review.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.storePage,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.mail_outline, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.email.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.email.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.email,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.apps, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.more_apps.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.more_apps.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.authorStore,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.people_outline, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.free_software.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.free_software.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.cherryGithub,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.code, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.flutter.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.flutter.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.flutterPage,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.public, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.imperial_units.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.imperial_units.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.internationalSystem,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.folder_open, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.credits.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.credits.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.spacexGithub,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          Separator.divider(height: 0.0, indent: 74.0),
          ListCell(
            leading: const Icon(Icons.copyright, size: 42.0),
            title: FlutterI18n.translate(
              context,
              'about.spacex.title',
            ),
            subtitle: FlutterI18n.translate(
              context,
              'about.spacex.body',
            ),
            onTap: () async => await launchURL(
                  url: Url.spacexPage,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
        ]),
      ),
    );
  }
}
