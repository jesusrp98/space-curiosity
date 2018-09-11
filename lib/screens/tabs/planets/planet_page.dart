import 'package:flutter/material.dart';

import '../../../models/planets/planet.dart';
import '../../../widgets/row_item.dart';
import 'add_edit_planet.dart';

class PlanetPage extends StatelessWidget {
  final Planet planet;

  PlanetPage(this.planet);

  @override
  Widget build(BuildContext context) {
    print(planet.moons);
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditPlanetPage(planet),
                    fullscreenDialog: true,
                  ),
                ).then((value) {
                  if (value != null) {
                    String _value = value;
                    if (_value.contains('deleted')) Navigator.pop(context);
                  }
                }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RowItem.textRow('Description', planet.description),
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
            RowItem.textRow(
                'Escape velocity', planet.escapeVelocity.toString()),
            RowItem.textRow('Tempperature', planet.temperature.toString()),
            RowItem.textRow('Pressure', planet.pressure.toString()),
            RowItem.textRow('Moons', planet.moons.toString())
          ],
        ),
      ),
    );
  }
}
