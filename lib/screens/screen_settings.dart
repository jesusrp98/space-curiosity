import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_model.dart';
import '../widgets/separator.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkTheme = true;
  bool _trueBlack = false;

  @override
  void initState() {
    var _model = ScopedModel.of<AppModel>(context);
    var _theme = _model?.theme ?? Themes.dark;

    if (_theme == Themes.light) setState(() => _darkTheme = false);

    if (_theme == Themes.black) setState(() => _trueBlack = true);

    super.initState();
  }

  void _changeTheme(BuildContext context,
      {Themes theme, AppModel model}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Dark mode'),
                  trailing: Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: _darkTheme,
                    onChanged: (value) => _changeTheme(
                          context,
                          model: model,
                          theme: value
                              ? _trueBlack ? Themes.black : Themes.dark
                              : Themes.light,
                        ),
                  ),
                ),
                _darkTheme
                    ? ListTile(
                        title: Text('OLED dark'),
                        trailing: Switch(
                          activeColor: Theme.of(context).accentColor,
                          value: _trueBlack,
                          onChanged: (value) => _changeTheme(
                                context,
                                model: model,
                                theme: value ? Themes.black : Themes.dark,
                              ),
                        ),
                      )
                    : Separator.none(),
              ],
            ),
      ),
    );
  }
}
