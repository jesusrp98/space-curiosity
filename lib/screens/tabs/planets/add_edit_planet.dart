import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/planets/planet.dart';

class AddEditPlanetPage extends StatelessWidget {
  static String routeName = "/add_planet";
  final Planet planet;

  AddEditPlanetPage(this.planet);

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<Planet>(
      model: Planet(id: planet?.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(planet == null ? "New Planet" : "Edit Planet"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScopedModelDescendant<Planet>(
            builder: (context, child, model) => ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Name'),
                      initialValue: planet?.name,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Description'),
                      initialValue: planet?.description,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Aphelion'),
                      initialValue: planet?.aphelion == null
                          ? null
                          : planet?.aphelion.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Perihelion'),
                      initialValue: planet?.perihelion == null
                          ? null
                          : planet?.perihelion.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Period'),
                      initialValue: planet?.period == null
                          ? null
                          : planet?.period.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Speed'),
                      initialValue:
                          planet?.speed == null ? null : planet?.speed.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Inclination'),
                      initialValue: planet?.inclination == null
                          ? null
                          : planet?.inclination.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Radius'),
                      initialValue: planet?.radius == null
                          ? null
                          : planet?.radius.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Volume'),
                      initialValue: planet?.volume == null
                          ? null
                          : planet?.volume.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Mass'),
                      initialValue:
                          planet?.mass == null ? null : planet?.mass.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Density'),
                      initialValue: planet?.density == null
                          ? null
                          : planet?.density.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Gravity'),
                      initialValue: planet?.gravity == null
                          ? null
                          : planet?.gravity.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Escape velocity'),
                      initialValue: planet?.escapeVelocity == null
                          ? null
                          : planet?.escapeVelocity.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Temperature'),
                      initialValue: planet?.temperature == null
                          ? null
                          : planet?.temperature.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Pressure'),
                      initialValue: planet?.pressure == null
                          ? null
                          : planet?.pressure.toString(),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
