import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../scoped_model/general_model.dart';
import '../../../scoped_model/launches_latest.dart';
import '../../../scoped_model/launches_upcoming.dart';
import '../../../scoped_model/vehicles.dart';
import 'tab_launches_latest.dart';
import 'tab_launches_upcoming.dart';
import 'tab_vehicles.dart';

class SpacexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpacexTabScreen();
}

class _SpacexTabScreen extends State<SpacexScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  static final List<GeneralModel> modelTab = [
    VehiclesModel(),
    LaunchesUpcomingModel(),
    LaunchesLatestModel(),
  ];

  final List<ScopedModel> _tabs = [
    ScopedModel<VehiclesModel>(
      model: modelTab[0],
      child: VehiclesTab(),
    ),
    ScopedModel<LaunchesUpcomingModel>(
      model: modelTab[1],
      child: LaunchesUpcomingTab(),
    ),
    ScopedModel<LaunchesLatestModel>(
      model: modelTab[2],
      child: LaunchesLatestTab(),
    ),
  ];

  @override
  initState() {
    super.initState();
    modelTab.forEach((model) => model.loadData());
  }

  void _onTabTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('SpaceX'), centerTitle: true),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: const Text('Vehicles'),
            icon: Icon(Icons.directions_car),
          ),
          BottomNavigationBarItem(
            title: const Text('Upcoming'),
            icon: Icon(Icons.timer),
          ),
          BottomNavigationBarItem(
            title: const Text('Latest'),
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
    );
  }
}
