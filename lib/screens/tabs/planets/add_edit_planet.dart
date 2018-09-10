import 'package:flutter/material.dart';

import '../../../models/planets/planet.dart';
import '../../../widgets/row_item.dart';

class AddEditPlanetPage extends StatelessWidget {
  static String routeName = "/add_planet";
  final Planet planet;

  AddEditPlanetPage(this.planet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet == null ? "New Planet" : "Edit Planet"),
      ),
      body: Column(
        children: <Widget>[
          Text(planet?.name ?? "No Name Found"),
          Text(planet?.description ?? "No Description Found"),
          RowItem.textRow('Aphelion', planet?.aphelion.toString()),
          RowItem.textRow('Perihelion', planet?.perihelion.toString()),
          RowItem.textRow('Period', planet?.period.toString()),
          RowItem.textRow('Speed', planet?.speed.toString()),
          RowItem.textRow('Inclination', planet?.inclination.toString()),
          RowItem.textRow('Radius', planet?.radius.toString()),
          RowItem.textRow('Volume', planet?.volume.toString()),
          RowItem.textRow('Mass', planet?.mass.toString()),
          RowItem.textRow('Density', planet?.density.toString()),
          RowItem.textRow('Gravity', planet?.gravity.toString()),
          RowItem.textRow('Escape velocity', planet?.escapeVelocity.toString()),
          RowItem.textRow('Tempperature', planet?.temperature.toString()),
          RowItem.textRow('Pressure', planet?.pressure.toString())
        ],
      ),
    );
  }
}
