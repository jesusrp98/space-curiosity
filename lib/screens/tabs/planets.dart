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
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final List planets = snapshot.data.documents
                    .map((document) => Planet.fromJson(document))
                    .toList();

                return ListView.builder(
                  itemCount: planets.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, planets[index]),
                );
              } else
                return const Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Planet planet) {
    return ListTile(
      title: Text(planet.name),
      subtitle: Text(planet.description),
    );
  }
}
