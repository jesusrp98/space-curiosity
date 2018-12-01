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
    var _model = ScopedModel.of<AppModel>(context);
    if (_model.theme == Themes.light) {
      setState(() {
        _darkTheme = false;
      });
    }
    print('Theme: ${_model.theme.toString()}');

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
                        model.theme = Themes.dark;
                      } else {
                        model.theme = Themes.light;
                      }
                      model.themeData = model.theme;
                      setState(() {
                        _darkTheme = value;
                      });
                      print('Theme: ${model.theme.toString()}');
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
