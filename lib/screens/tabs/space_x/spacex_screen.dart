import 'package:space_news/screens/tabs/space_x/launch_list.dart';
import 'package:space_news/screens/tabs/space_x/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:space_news/util/url.dart';

class SpacexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpacexTabScreen();
}

class _SpacexTabScreen extends State<SpacexScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  List<StatelessWidget> _homeLists = List(_tabs.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('SpaceX'),
        centerTitle: true,
        bottom: TabBar(
          labelStyle: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.bold,
          ),
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _homeLists),
    );
  }

  /// List of the TabBar's tabs
  static const List<Tab> _tabs = const <Tab>[
    const Tab(text: 'VEHICLES'),
    const Tab(text: 'UPCOMING'),
    const Tab(text: 'LATEST'),
  ];

  @override
  void initState() {
    super.initState();

    // Tab controller init
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 1,
    );

    // List array init
    _homeLists = [
      VehicleList(),
      LaunchList(Url.upcomingList),
      LaunchList(Url.launchesList),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
