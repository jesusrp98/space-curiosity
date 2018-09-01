import 'package:flutter/material.dart';

import 'package:space_news/models/planet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlanetsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planets')),
      body: StreamBuilder(
        stream: Firestore.instance.collection('planets').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          final List<Planet> planets = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, planets[index]),
          );
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Planet planet) {
    print(planet);
    return ListTile(
      title: Text("asd"),
      subtitle: Text("asd"),
    );
  }
}
