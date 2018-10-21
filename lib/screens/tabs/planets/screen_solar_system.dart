import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/planets/celestial_body.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/list_cell.dart';
import 'add_edit_planet.dart';
import 'page_celestial_body.dart';

class SolarSystemScreen extends StatelessWidget {
  final PlanetsModel planetModel;
  SolarSystemScreen({this.planetModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solar System'), centerTitle: true),
      body: ScopedModelDescendant<PlanetsModel>(
        builder: (context, child, model) => model.isLoading
            ? NativeLoadingIndicator(center: true)
            : Scrollbar(
                child: ListView.builder(
                  key: PageStorageKey('planets'),
                  itemCount: model.getSize,
                  itemBuilder: _buildItem,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddEditPlanetPage(null, type: BodyType.planet),
                fullscreenDialog: true,
              ),
            ),
      ),
    );
  }

  Widget _buildMoons(
    BuildContext context,
    int index,
    List<CelestialBody> moons,
  ) {
    List<Widget> _moons = [];
    for (var moon in moons)
      _moons.add(
        ListCell(
          leading: HeroImage().buildHero(
            context: context,
            size: HeroImage.smallSize,
            url: moon.imageUrl,
            tag: moon.id,
            title: moon.name,
          ),
          title: moon.name,
          subtitle: moon.description,
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CelestialBodyPage(
                        celestialBody: moon,
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
                  size: HeroImage.smallSize,
                  url: model.getItem(index).imageUrl,
                  tag: model.getItem(index).id,
                  title: model.getItem(index).name,
                ),
                title: model.getItem(index).name,
                subtitle: model.getItem(index).description,
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () async {
                    var _moons = await model
                        .getItem(index)
                        .getMoons(model.getItem(index).id);
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
                        builder: (context) => CelestialBodyPage(
                              celestialBody: model.getItem(index),
                              type: BodyType.planet,
                            ),
                      ),
                    ),
              ),
        ),
        const Divider(height: 0.0, indent: 104.0)
      ],
    );
  }
}
