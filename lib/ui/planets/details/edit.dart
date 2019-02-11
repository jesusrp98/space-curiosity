import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/models/planets/celestial_body.dart';

class AddEditPlanetPage extends StatelessWidget {
  static String routeName = "/add_planet";
  final CelestialBody planet;
  final BodyType type;
  final String id;

  AddEditPlanetPage(this.planet, {@required this.type, this.id});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> nameKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> descriptionKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> imageKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<num>> aphelionKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> perihelionKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> periodKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> speedKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> inclinationKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> radiusKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> volumeKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> massKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> densityKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> gravityKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> escapeVelocityKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> temperatureKey =
      GlobalKey<FormFieldState<num>>();
  static final GlobalKey<FormFieldState<num>> pressureKey =
      GlobalKey<FormFieldState<num>>();

  String getTitle() {
    switch (type) {
      case BodyType.planet:
        if (planet == null) return "New Planet";
        return "Edit Planet";
        break;
      case BodyType.celestialBody:
        if (planet == null) return "New Moon";
        return "Edit Moon";
        break;
      default:
        return "New Planet";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<CelestialBody>(
      model: CelestialBody(id: type == BodyType.planet ? planet?.id : null),
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
          actions: <Widget>[
            ScopedModelDescendant<CelestialBody>(
              builder: (context, child, model) => IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: planet == null
                        ? null
                        : () {
                            model.removePlanet(planet);
                            Navigator.pop(context, 'deleted');
                          },
                  ),
            ),
            ScopedModelDescendant<CelestialBody>(
              builder: (context, child, model) => IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        var _planet = CelestialBody(
                          id: planet?.id,
                          name: nameKey?.currentState?.value ?? '',
                          description: descriptionKey?.currentState?.value,
                          imageUrl: imageKey?.currentState?.value,
                          aphelion: aphelionKey?.currentState?.value,
                          perihelion: pressureKey?.currentState?.value,
                          period: periodKey?.currentState?.value,
                          speed: speedKey?.currentState?.value,
                          obliquity: inclinationKey?.currentState?.value,
                          radius: radiusKey?.currentState?.value,
                          volume: volumeKey?.currentState?.value,
                          mass: massKey?.currentState?.value,
                          density: densityKey?.currentState?.value,
                          gravity: gravityKey?.currentState?.value,
                          escapeVelocity:
                              escapeVelocityKey?.currentState?.value,
                          temperature: temperatureKey?.currentState?.value,
                          pressure: pressureKey?.currentState?.value,
                        );
                        switch (type) {
                          case BodyType.planet:
                            planet == null
                                ? model.addPlanet(_planet)
                                : model.editPlanet(_planet);
                            break;
                          case BodyType.celestialBody:
                            planet == null
                                ? model.addMoon(id, _planet)
                                : model.editMoon(id, _planet);
                            break;
                          default:
                            planet == null
                                ? model.addPlanet(_planet)
                                : model.editPlanet(_planet);
                        }
                        Navigator.pop(context, true);
                      }
                    },
                  ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScopedModelDescendant<CelestialBody>(
            builder: (context, child, model) => Form(
                  key: formKey,
                  autovalidate: false,
                  onWillPop: () => Future(() => true),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          key: nameKey,
                          decoration: InputDecoration(labelText: 'Name'),
                          initialValue: planet?.name,
                          validator: (String value) =>
                              value.isNotEmpty ? null : 'Name Required',
                        ),
                        TextFormField(
                          key: descriptionKey,
                          decoration: InputDecoration(labelText: 'Description'),
                          initialValue: planet?.description,
                        ),
                        TextFormField(
                          key: imageKey,
                          decoration: InputDecoration(labelText: 'Image URL'),
                          initialValue: planet?.imageUrl,
                          validator: (String value) =>
                              value.isNotEmpty ? null : 'Image Required',
                        ),
                        TextFormField(
                          key: aphelionKey,
                          decoration: InputDecoration(labelText: 'Aphelion'),
                          initialValue: planet?.aphelion == null
                              ? null
                              : planet?.aphelion.toString(),
                        ),
                        TextFormField(
                          key: perihelionKey,
                          decoration: InputDecoration(labelText: 'Perihelion'),
                          initialValue: planet?.perihelion == null
                              ? null
                              : planet?.perihelion.toString(),
                        ),
                        TextFormField(
                          key: periodKey,
                          decoration: InputDecoration(labelText: 'Period'),
                          initialValue: planet?.period == null
                              ? null
                              : planet?.period.toString(),
                        ),
                        TextFormField(
                          key: speedKey,
                          decoration: InputDecoration(labelText: 'Speed'),
                          initialValue: planet?.speed == null
                              ? null
                              : planet?.speed.toString(),
                        ),
                        TextFormField(
                          key: inclinationKey,
                          decoration: InputDecoration(labelText: 'Inclination'),
                          initialValue: planet?.obliquity == null
                              ? null
                              : planet?.obliquity.toString(),
                        ),
                        TextFormField(
                          key: radiusKey,
                          decoration: InputDecoration(labelText: 'Radius'),
                          initialValue: planet?.radius == null
                              ? null
                              : planet?.radius.toString(),
                        ),
                        TextFormField(
                          key: volumeKey,
                          decoration: InputDecoration(labelText: 'Volume'),
                          initialValue: planet?.volume == null
                              ? null
                              : planet?.volume.toString(),
                        ),
                        TextFormField(
                          key: massKey,
                          decoration: InputDecoration(labelText: 'Mass'),
                          initialValue: planet?.mass == null
                              ? null
                              : planet?.mass.toString(),
                        ),
                        TextFormField(
                          key: densityKey,
                          decoration: InputDecoration(labelText: 'Density'),
                          initialValue: planet?.density == null
                              ? null
                              : planet?.density.toString(),
                        ),
                        TextFormField(
                          key: gravityKey,
                          decoration: InputDecoration(labelText: 'Gravity'),
                          initialValue: planet?.gravity == null
                              ? null
                              : planet?.gravity.toString(),
                        ),
                        TextFormField(
                          key: escapeVelocityKey,
                          decoration:
                              InputDecoration(labelText: 'Escape velocity'),
                          initialValue: planet?.escapeVelocity == null
                              ? null
                              : planet?.escapeVelocity.toString(),
                        ),
                        TextFormField(
                          key: temperatureKey,
                          decoration: InputDecoration(labelText: 'Temperature'),
                          initialValue: planet?.temperature == null
                              ? null
                              : planet?.temperature.toString(),
                        ),
                        TextFormField(
                          key: pressureKey,
                          decoration: InputDecoration(labelText: 'Pressure'),
                          initialValue: planet?.pressure == null
                              ? null
                              : planet?.pressure.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
