import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/widgets/hero_image.dart';
import 'package:space_news/widgets/list_cell.dart';

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

  Widget _buildMoons(
      BuildContext context, int index, List<CelestialBody> moons) {
    if (moons == null || moons.isEmpty) {
      return Center(child: Text('No Moons Found'));
    }
    return ListView.builder(
        itemCount: moons.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            moons[index].name,
            textAlign: TextAlign.center,
          );
        });
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
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: _buildMoons(context, index, _moons),
                            ),
                          ),
                        );
                      },
                    );
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
