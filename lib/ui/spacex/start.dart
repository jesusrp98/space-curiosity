import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/spacex/index.dart';
import 'tabs/index.dart';

/// This view holds all tabs & its models: home, vehicles, upcoming & latest launches, & company tabs.
class SpaceXScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpaceXScreenState();
}

class _SpaceXScreenState extends State<SpaceXScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Reading app shortcuts input
    final QuickActions quickActions = QuickActions();
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
    final List<SingleChildCloneableWidget> _models = [
      ChangeNotifierProvider<SpacexHomeModel>(
        builder: (context) => SpacexHomeModel(context),
        child: HomeTab(),
      ),
      ChangeNotifierProvider<VehiclesModel>(
        builder: (context) => VehiclesModel(),
        child: VehiclesTab(),
      ),
      ChangeNotifierProvider<LaunchesModel>(
        builder: (context) => LaunchesModel(Launches.upcoming),
        child: const LaunchesTab(Launches.upcoming),
      ),
      ChangeNotifierProvider<LaunchesModel>(
        builder: (context) => LaunchesModel(Launches.latest),
        child: const LaunchesTab(Launches.latest),
      ),
      ChangeNotifierProvider<SpacexCompanyModel>(
        builder: (context) => SpacexCompanyModel(),
        child: CompanyTab(),
      ),
    ];

    return MultiProvider(
      providers: _models,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _models),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontFamily: 'ProductSans'),
          unselectedLabelStyle: TextStyle(fontFamily: 'ProductSans'),
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
