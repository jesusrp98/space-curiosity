import 'package:flutter/material.dart';

import '../../../models/planets/celestial_body.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/head_card_page.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/row_item.dart';
import 'add_edit_planet.dart';

class PlanetPage extends StatelessWidget {
  final CelestialBody planet;
  final BodyType type;

  PlanetPage({this.planet, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
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
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditPlanetPage(planet, type: type),
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
      body: SafeArea(
        child: Scrollbar(
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
      ),
    );
  }

  Widget _headCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        context: context,
        size: HeroImage.bigSize,
        url: planet.imageUrl,
        tag: planet.id,
        title: planet.name,
      ),
      title: planet.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            planet.getPopulation,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            "I'm a subtitle!",
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
    return CardPage(
      title: 'DETAILS',
      body: Column(
        children: <Widget>[
          RowItem.textRow('Aphelion', planet.getAphelion),
          const SizedBox(height: 8.0),
          RowItem.textRow('Perihelion', planet.getPerihelion),
          const SizedBox(height: 8.0),
          RowItem.textRow('Period', planet.getPeriod),
          const SizedBox(height: 8.0),
          RowItem.textRow('Speed', planet.getSpeed),
          const SizedBox(height: 8.0),
          RowItem.textRow('Obliquity', planet.getObliquity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Radius', planet.getRadius),
          const SizedBox(height: 8.0),
          RowItem.textRow('Volume', planet.getVolume),
          const SizedBox(height: 8.0),
          RowItem.textRow('Mass', planet.getMass),
          const SizedBox(height: 8.0),
          RowItem.textRow('Density', planet.getDensity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Gravity', planet.getGravity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Escape velocity', planet.getEscapeVelocity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Temperature', planet.getTemperature),
          const SizedBox(height: 8.0),
          RowItem.textRow('Pressure', planet.getPressure),
        ],
      ),
    );
  }
}
