import 'package:flutter/material.dart';

import 'package:space_news/models/planet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:space_news/screens/tabs/planet_page.dart';

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
    return Column(
      children: <Widget>[
        ListTile(
          leading: SizedBox(
            width: 72.0,
            height: 72.0,
            child: CachedNetworkImage(imageUrl: planet.imageUrl),
          ),
          title: Text(planet.name),
          subtitle: Text(planet.description),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlanetPage(planet)),
              ),
        ),
        const Divider(height: 0.0, indent: 104.0)
      ],
    );
  }
}
