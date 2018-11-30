import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/app_model.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          new ScopedModelDescendant<AppModel>(
            builder: (context, child, model) {
              return ListTile(
                title: Text("Change Theme"),
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.light,
                  onChanged: (bool value) =>
                      _changeTheme(context, value, model),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _changeTheme(BuildContext context, bool value, AppModel model) {
    if (value) {
      model.changeTheme(context, theme: Themes.light);
    } else {
      model.changeTheme(context, theme: Themes.dark);
    }
  }
}
