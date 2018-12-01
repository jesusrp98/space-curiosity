import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/app_model.dart';
import '../util/colors.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkTheme = true;

  @override
  void initState() {
    // _darkTheme = Theme.of(context).brightness == Brightness.light;
    // _darkTheme = widget.model.theme == Themes.dark;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: <Widget>[
          new ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => ListTile(
                  title: Text("Dark Theme"),
                  trailing: Switch(
                    value: _darkTheme,
                    onChanged: (bool value) {
                      if (value) {
                        model.themeData = Themes.dark;
                      } else {
                        model.themeData = Themes.light;
                      }
                      setState(() {
                        _darkTheme = value;
                      });
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
