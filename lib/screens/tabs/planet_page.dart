import 'package:flutter/material.dart';

import '../../models/planet.dart';
import '../../widgets/row_item.dart';

class PlanetPage extends StatelessWidget {
  final Planet planet;

  PlanetPage(this.planet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
      ),
      body: Column(
        children: <Widget>[
          Text(planet.description),
          RowItem.textRow('Aphelion', planet.aphelion.toString()),
          RowItem.textRow('Perihelion', planet.perihelion.toString()),
          RowItem.textRow('Period', planet.period.toString()),
          RowItem.textRow('Speed', planet.speed.toString()),
          RowItem.textRow('Inclination', planet.inclination.toString()),
          RowItem.textRow('Radius', planet.radius.toString()),
          RowItem.textRow('Volume', planet.volume.toString()),
          RowItem.textRow('Mass', planet.mass.toString()),
          RowItem.textRow('Density', planet.density.toString()),
          RowItem.textRow('Gravity', planet.gravity.toString()),
          RowItem.textRow('Escape velocity', planet.escapeVelocity.toString()),
          RowItem.textRow('Tempperature', planet.temperature.toString()),
          RowItem.textRow('Pressure', planet.pressure.toString())
        ],
      ),
    );
  }
}
