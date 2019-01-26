import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_model.dart';
import '../widgets/separator.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen();

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkTheme = false;
  bool _oledBlack = false;

  @override
  void initState() {
    var _theme = ScopedModel.of<AppModel>(context)?.theme ?? Themes.dark;

    if (_theme == Themes.light)
      setState(() {
        _darkTheme = false;
        _oledBlack = false;
      });
    else if (_theme == Themes.black)
      setState(() {
        _darkTheme = true;
        _oledBlack = true;
      });
    else
      setState(() {
        _darkTheme = true;
        _oledBlack = false;
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Dark theme'),
                  subtitle: Text('For the lovers of the dark side'),
                  trailing: Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: _darkTheme,
                    onChanged: (value) => _changeTheme(
                          model: model,
                          theme: value
                              ? _oledBlack ? Themes.black : Themes.dark
                              : Themes.light,
                        ),
                  ),
                ),
                ListTile(
                  title: Text('OLED black'),
                  subtitle: Text('Select this for TRUE blacks'),
                  trailing: Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: _oledBlack,
                    onChanged: (value) => _changeTheme(
                          model: model,
                          theme: value ? Themes.black : Themes.dark,
                        ),
                  ),
                ),
                Separator.divider(),
              ],
            ),
      ),
    );
  }

  void _changeTheme({AppModel model, Themes theme}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (theme == Themes.dark) {
      model.theme = Themes.dark;
      prefs.setString('theme', 'dark');
      setState(() {
        _darkTheme = true;
        _oledBlack = false;
      });
    } else if (theme == Themes.black) {
      model.theme = Themes.black;
      prefs.setString('theme', 'black');
      setState(() {
        _darkTheme = true;
        _oledBlack = true;
      });
    } else {
      model.theme = Themes.light;
      prefs.setString('theme', 'light');
      setState(() {
        _darkTheme = false;
        _oledBlack = false;
      });
    }
    model.themeData = model.theme;
  }
}
