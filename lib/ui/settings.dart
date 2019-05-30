import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:row_collection/row_collection.dart';

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
      body: ListView(
        children: <Widget>[
          DarkModeSwitch(
            title: Text(FlutterI18n.translate(
              context,
              'settings.dark_theme.title',
            )),
            subtitle: Text(FlutterI18n.translate(
              context,
              'settings.dark_theme.body',
            )),
          ),
          TrueBlackSwitch(
            title: Text(FlutterI18n.translate(
              context,
              'settings.oled_black.title',
            )),
            subtitle: Text(FlutterI18n.translate(
              context,
              'settings.oled_black.body',
            )),
          ),
          CustomThemeSwitch(),
          PrimaryColorPicker(
            type: PickerType.material,
          ),
          AccentColorPicker(
            type: PickerType.material,
          ),
          DarkAccentColorPicker(
            type: PickerType.material,
          ),
          Separator.divider(),
        ],
      ),
    );
  }
}
