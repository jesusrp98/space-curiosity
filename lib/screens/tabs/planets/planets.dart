import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/planets/planets.dart';
import '../../../models/planets/celestial_body.dart';
import 'add_edit_planet.dart';
import 'planet_page.dart';

class PlanetsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<PlanetsModel>(
      model: PlanetsModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Planets')),
        body: ScopedModelDescendant<PlanetsModel>(
          builder: (context, child, model) => FutureBuilder(
                future: model.loadData(),
                builder: (BuildContext context, _) {
                  if (model.planets == null)
                    return NativeLoadingIndicator(
                      center: true,
                      text: Text("Loading..."),
                    );

                  if (model.planets.isEmpty)
                    return Center(child: Text("No Planets Found"));

                  return ListView.builder(
                    itemCount: model.planets.length,
                    itemBuilder: _buildItem,
                  );
                },
              ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPlanetPage(
                        null,
                        type: BodyType.planet,
                      ),
                  fullscreenDialog: true,
                ),
              ),
        ),
      ),
    );
  }

  Widget buildMoons(BuildContext context, CelestialBody planet) {
    if (planet?.moons?.isEmpty ?? true)
      return Center(child: Text('No Moons Found'));

    return ListView.builder(
        itemCount: planet?.moons?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Name"),
            subtitle: Text(planet?.moons[index]?.name ?? "No Name Found"),
          );
        });
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<PlanetsModel>(
          builder: (context, child, model) => ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: SizedBox(
                  width: 72.0,
                  height: 72.0,
                  child: CachedNetworkImage(
                      imageUrl: model.planets[index].imageUrl),
                ),
                title: Text(
                  model.planets[index].name,
                  maxLines: 1,
                ),
                subtitle: Text(
                  model.planets[index].description,
                  maxLines: 3,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: buildMoons(context, model.planets[index]),
                          ));
                        });
                  },
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlanetPage(model.planets[index])),
                    ),
              ),
        ),
        const Divider(height: 0.0, indent: 104.0)
      ],
    );
  }
}
