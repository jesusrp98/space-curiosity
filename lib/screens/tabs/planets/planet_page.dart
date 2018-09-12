import 'package:flutter/material.dart';
import 'package:space_news/util/colors.dart';
import 'package:space_news/widgets/card_page.dart';
import 'package:space_news/widgets/head_card_page.dart';
import 'package:space_news/widgets/hero_image.dart';

import '../../../models/planets/celestial_body.dart';
import '../../../widgets/row_item.dart';
import 'add_edit_planet.dart';

class PlanetPage extends StatelessWidget {
  final CelestialBody planet;

  PlanetPage(this.planet);

  @override
  Widget build(BuildContext context) {
    // print(planet.moons);
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditPlanetPage(
                          planet,
                          type: BodyType.planet,
                        ),
                    fullscreenDialog: true,
                  ),
                ).then((value) {
                  if (value != null) {
                    String _value = value;
                    if (_value.contains('deleted')) Navigator.pop(context);
                  }
                }),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              _headCard(context),
              const SizedBox(height: 8.0),
              _detailsCard(context),
            ]),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add Moon"),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditPlanetPage(
                      null,
                      id: planet.id,
                      type: BodyType.celestialBody,
                    ),
                fullscreenDialog: true,
              ),
            ).then(
              (value) {
                if (value != null) {
                  String _value = value;
                  if (_value.contains('deleted')) Navigator.pop(context);
                }
              },
            ),
      ),
    );
  }

  Widget _headCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        size: 116.0,
        context: context,
        url: planet.imageUrl,
        tag: planet.id,
        title: planet.name,
      ),
      title: planet.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "I'm a subtitle",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            "Me too!",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
        ],
      ),
      details: planet.description,
    );
  }

  Widget _detailsCard(BuildContext context) {
    return CardPage(title: 'DETAILS', body: <Widget>[
      RowItem.textRow('Aphelion', planet.aphelion.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Perihelion', planet.perihelion.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Period', planet.period.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Speed', planet.speed.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Inclination', planet.inclination.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Radius', planet.radius.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Volume', planet.volume.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Mass', planet.mass.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Density', planet.density.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Gravity', planet.gravity.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Escape velocity', planet.escapeVelocity.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Tempperature', planet.temperature.toString()),
      const SizedBox(height: 8.0),
      RowItem.textRow('Pressure', planet.pressure.toString()),
    ]);
  }
}
