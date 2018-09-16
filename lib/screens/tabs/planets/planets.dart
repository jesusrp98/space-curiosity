import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/planets/celestial_body.dart';
import '../../../models/planets/planets.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/list_cell.dart';
import 'add_edit_planet.dart';
import 'planet_page.dart';

class PlanetsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planets')),
      body: ScopedModelDescendant<PlanetsModel>(
        builder: (context, child, model) => StreamBuilder(
              stream: model.loadData().asStream().distinct(),
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
    );
  }

  Widget _buildMoons(
      BuildContext context, int index, List<CelestialBody> moons) {
    List<Widget> _moons = [];
    for (var moon in moons)
      _moons.add(
        ListCell(
          leading: HeroImage().buildHero(
            context: context,
            url: moon.imageUrl,
            tag: moon.id,
            title: moon.name,
          ),
          title: moon.name,
          subtitle: moon.description,
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetPage(
                        planet: moon,
                        type: BodyType.celestialBody,
                      ),
                ),
              ),
        ),
      );

    if (_moons.isEmpty)
      _moons.add(ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Icon(Icons.info),
        title: Text('No Moons Found'),
      ));

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _moons,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<PlanetsModel>(
          builder: (context, child, model) => ListCell(
                leading: HeroImage().buildHero(
                  context: context,
                  url: model.planets[index].imageUrl,
                  tag: model.planets[index].id,
                  title: model.planets[index].name,
                ),
                title: model.planets[index].name,
                subtitle: model.planets[index].description,
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () async {
                    var _moons = await model.planets[index]
                        .getMoons(model.planets[index].id);
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Container(
                            child: _buildMoons(context, index, _moons),
                          ),
                        );
                      },
                    );
                  },
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlanetPage(
                                planet: model.planets[index],
                                type: BodyType.planet,
                              )),
                    ),
              ),
        ),
        const Divider(height: 0.0, indent: 104.0)
      ],
    );
  }
}
