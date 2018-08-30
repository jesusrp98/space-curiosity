import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/database.dart';
import '../models/counter.dart';
import 'space_x/home_page.dart';
import 'tabs/facts.dart';
import 'tabs/news.dart';

enum TabItem {
  news,
  facts,
  spaceX,
}

String tabItemName(TabItem tabItem) {
  switch (tabItem) {
    case TabItem.news:
      return "News";
    case TabItem.facts:
      return "Facts";
    case TabItem.spaceX:
      return "Space X";
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
        _updateCurrentItem(TabItem.facts);
        break;
      case 2:
        _updateCurrentItem(TabItem.spaceX);
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
          child: NewsPage(database: database),
        );
      case TabItem.facts:
        return ScopedModel<CountersModel>(
          model: CountersModel(stream: stream),
          child: FactsPage(database: database),
        );
      case TabItem.spaceX:
        return HomePage();
    }
    return Container();
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(icon: Icons.description, tabItem: TabItem.news),
        _buildItem(icon: Icons.new_releases, tabItem: TabItem.facts),
        _buildItem(icon: Icons.info, tabItem: TabItem.spaceX),
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
