import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../data/models/spacex/info_vehicle.dart';
import '../../data/models/spacex/launch.dart';
import '../../data/models/spacex/spacex_company.dart';
import '../../data/models/spacex/spacex_home.dart';
import 'tabs/company.dart';
import 'tabs/home.dart';
import 'tabs/launches.dart';
import 'tabs/vehicles.dart';

/// START SCREEN
/// This view holds all tabs & its models: home, vehicles, upcoming & latest launches, & company tabs.
class SpaceXScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<SpaceXScreen> {
  int _currentIndex = 0;

  @override
  initState() {
    super.initState();

    // Reading app shortcuts input
    final QuickActions quickActions = const QuickActions();
    quickActions.initialize((type) {
      switch (type) {
        case 'vehicles':
          setState(() => _currentIndex = 1);
          break;
        case 'upcoming':
          setState(() => _currentIndex = 2);
          break;
        case 'latest':
          setState(() => _currentIndex = 3);
          break;
        default:
          setState(() => _currentIndex = 0);
      }
    });

    Future.delayed(Duration.zero, () async {
      // Setting app shortcuts
      quickActions.setShortcutItems(<ShortcutItem>[
        ShortcutItem(
          type: 'vehicles',
          localizedTitle: FlutterI18n.translate(
            context,
            'spacex.vehicle.icon',
          ),
          icon: 'action_vehicle',
        ),
        ShortcutItem(
          type: 'upcoming',
          localizedTitle: FlutterI18n.translate(
            context,
            'spacex.upcoming.icon',
          ),
          icon: 'action_upcoming',
        ),
        ShortcutItem(
          type: 'latest',
          localizedTitle: FlutterI18n.translate(
            context,
            'spacex.latest.icon',
          ),
          icon: 'action_latest',
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeTab(),
      VehiclesTab(),
      LaunchesTab(0),
      LaunchesTab(1),
      CompanyTab(),
    ];
    return MultiProvider(
      providers: [
        ListenableProvider.value(value: SpacexHomeModel()..loadData(context)),
        ListenableProvider.value(value: VehiclesModel()..loadData(context)),
        ListenableProvider.value(value: LaunchesModel(0)..loadData(context)),
        ListenableProvider.value(value: LaunchesModel(1)..loadData(context)),
        ListenableProvider.value(
            value: SpacexCompanyModel()..loadData(context)),
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
                'spacex.home.icon',
              )),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'spacex.vehicle.icon',
              )),
              icon: Icon(FontAwesomeIcons.rocket),
            ),
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'spacex.upcoming.icon',
              )),
              icon: Icon(Icons.access_time),
            ),
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'spacex.latest.icon',
              )),
              icon: Icon(Icons.library_books),
            ),
            BottomNavigationBarItem(
              title: Text(FlutterI18n.translate(
                context,
                'spacex.company.icon',
              )),
              icon: Icon(Icons.location_city),
            ),
          ],
        ),
      ),
    );
  }
}
