import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../data/models/theme/theme.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO revisar
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'home.menu.settings',
        )),
        centerTitle: true,
      ),
      body: Consumer<ThemeModel>(
        builder: (context, theme, child) => ListView(
              children: <Widget>[
                ListTile(
                  title: Text(FlutterI18n.translate(
                    context,
                    'settings.dark_theme.title',
                  )),
                  subtitle: Text(FlutterI18n.translate(
                    context,
                    'settings.dark_theme.body',
                  )),
                  trailing: Switch.adaptive(
                    value: theme.darkMode,
                    onChanged: theme.changeBrightnessDark,
                  ),
                ),
                ListTile(
                  title: Text(FlutterI18n.translate(
                    context,
                    'Use System Setting',
                  )),
                  subtitle: Text(FlutterI18n.translate(
                    context,
                    'Device Settings Control Brightness',
                  )),
                  trailing: Switch.adaptive(
                    value: theme.useSystemSetting,
                    onChanged: theme.changeSystemDark,
                  ),
                ),
                Separator.divider(),
              ],
            ),
      ),
    );
  }
}
