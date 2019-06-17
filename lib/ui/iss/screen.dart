import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../data/models/iss/astronauts.dart';
import '../../data/models/iss/iss_home.dart';
import '../../data/models/iss/pass_time.dart';
import 'tabs/astronauts.dart';
import 'tabs/home.dart';
import 'tabs/pass_times.dart';

/// ISS SCREEN
/// This view holds all tabs & its models: home, pass times & current astronauts.
class IssScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IssScreenState();
}

class _IssScreenState extends State<IssScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeTab(),
      PassTimesTab(),
      AstronautsTab(),
    ];
    return MultiProvider(
      providers: [
        ListenableProvider.value(value: IssHomeModel()..loadData(context)),
        ListenableProvider.value(value: PassTimesModel()..loadData(context)),
        ListenableProvider.value(value: AstronautsModel()..loadData(context)),
      ],
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            for (int i = 0; i < _screens.length; i++) ...[
              Offstage(
                offstage: i != _currentIndex,
                child: _screens[i],
              ),
            ],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'iss.home.icon',
              )),
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'iss.times.icon',
              )),
              icon: const Icon(Icons.timer),
            ),
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'iss.astronauts.icon',
              )),
              icon: const Icon(Icons.people),
            ),
          ],
        ),
      ),
    );
  }
}
