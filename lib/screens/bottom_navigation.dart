import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/screens/tabs/planets.dart';

import '../data/database.dart';
import '../models/counter.dart';
import 'tabs/nasa/home_page.dart';
import 'tabs/space_x/home_page.dart';
import 'tabs/news.dart';

enum TabItem {
  news,
  planets,
  spaceX,
  nasa,
}

String tabItemName(TabItem tabItem) {
  switch (tabItem) {
    case TabItem.news:
      return "News";
    case TabItem.spaceX:
      return "SpaceX";
    case TabItem.nasa:
      return "NASA";
    case TabItem.planets:
      return "Planets";
  }
  return null;
}

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  TabItem currentItem = TabItem.news;

  _onSelectTab(int index) {
    switch (index) {
      case 0:
        _updateCurrentItem(TabItem.news);
        break;
      case 1:
        _updateCurrentItem(TabItem.spaceX);
        break;
      case 2:
        _updateCurrentItem(TabItem.nasa);
        break;
      case 3:
        _updateCurrentItem(TabItem.planets);
        break;
    }
  }

  _updateCurrentItem(TabItem item) => setState(() => currentItem = item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    var database = AppFirestore();
    var stream = database.countersStream();
    switch (currentItem) {
      case TabItem.news:
        return ScopedModel<CountersModel>(
          model: CountersModel(stream: stream),
          child: NewsHomePage(database: database),
        );
      case TabItem.spaceX:
        return SpaceXHomePage();
      case TabItem.nasa:
        return NasaHomePage();
      case TabItem.planets:
        return PlanetsHomePage();
    }
    return Container();
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(icon: Icons.description, tabItem: TabItem.news),
        _buildItem(icon: Icons.info, tabItem: TabItem.spaceX),
        _buildItem(icon: FontAwesomeIcons.spaceShuttle, tabItem: TabItem.nasa),
        _buildItem(icon: Icons.public, tabItem: TabItem.planets),
      ],
      onTap: _onSelectTab,
    );
  }

  BottomNavigationBarItem _buildItem({IconData icon, TabItem tabItem}) {
    String text = tabItemName(tabItem);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    // return currentItem == item ? Theme.of(context).primaryColor : Colors.grey;
    return currentItem == item ? Colors.orange : Colors.grey;
  }
}
