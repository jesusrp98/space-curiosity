import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/app_model.dart';
import '../util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkTheme = true;
  bool _trueBlack = false;

  @override
  void initState() {
    var _model = ScopedModel.of<AppModel>(context);
    var _theme = _model?.theme ?? Themes.dark;
    if (_theme == Themes.light) {
      setState(() {
        _darkTheme = false;
      });
    }
    if (_theme == Themes.black) {
      setState(() {
        _trueBlack = true;
      });
    }
    print('Theme: ${_model.theme.toString()}');

    super.initState();
  }

  void _changeTheme(BuildContext context,
      {Themes theme, AppModel model}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (theme == Themes.dark) {
      model.theme = Themes.dark;
      prefs.setString("theme", "dark");
      setState(() {
        _darkTheme = true;
        _trueBlack = false;
      });
    } else if (theme == Themes.black) {
      model.theme = Themes.black;
      prefs.setString("theme", "black");
      setState(() {
        _darkTheme = true;
        _trueBlack = true;
      });
    } else {
      model.theme = Themes.light;
      prefs.setString("theme", "light");
      setState(() {
        _darkTheme = false;
        // _trueBlack = false;
      });
    }
    model.themeData = model.theme;
    print('Theme: ${model.theme.toString()}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: new ScopedModelDescendant<AppModel>(
          builder: (context, child, model) => ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Dark Theme"),
                    trailing: Switch(
                      value: _darkTheme,
                      onChanged: (bool value) => _changeTheme(context,
                          model: model,
                          theme: value ? Themes.dark : Themes.light),
                    ),
                  ),
                  _darkTheme
                      ? ListTile(
                          title: Text("True Black"),
                          trailing: Switch(
                            value: _trueBlack,
                            onChanged: (bool value) => _changeTheme(context,
                                model: model,
                                theme: value ? Themes.black : Themes.dark),
                          ),
                        )
                      : Container(),
                ],
              )),
    );
  }
}
