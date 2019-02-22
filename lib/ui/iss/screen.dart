import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/iss/astronauts.dart';
import '../../models/iss/iss_home.dart';
import '../../models/iss/pass_time.dart';
import '../../models/query_model.dart';
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

  static final List<QueryModel> _modelTab = [
    IssHomeModel(),
    PassTimesModel(),
    AstronautsModel(),
  ];

  static final List<ScopedModel> _tabs = [
    ScopedModel<IssHomeModel>(
      model: _modelTab[0],
      child: HomeTab(),
    ),
    ScopedModel<PassTimesModel>(
      model: _modelTab[1],
      child: PassTimesTab(),
    ),
    ScopedModel<AstronautsModel>(
      model: _modelTab[2],
      child: AstronautsTab(),
    ),
  ];

  @override
  initState() {
    super.initState();
    _modelTab.forEach((model) => model.loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
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
    );
  }
}
