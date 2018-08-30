import 'package:flutter/material.dart';

import '../../data/database.dart';

class FactsPage extends StatelessWidget {
  FactsPage({this.database});
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facts'),
        elevation: 1.0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Facts about the Moon...'),
        ),
        ListTile(
          title: Text('Facts about the Sun...'),
        ),
        ListTile(
          title: Text('Facts about the Earth...'),
        ),
      ],
    );
  }
}
