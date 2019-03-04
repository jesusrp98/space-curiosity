import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../query_model.dart';

enum BodyType { planet, celestialBody }

var planetsPath = Firestore.instance.collection('planets');

class PlanetsModel extends QueryModel {
  @override
  Future loadData() async {
    response = await planetsPath.getDocuments();

    items.addAll(response.documents
        .map((document) => CelestialBody.fromJson(document))
        .toList());

    setLoading(false);
  }
}

class CelestialBody extends Model {
  Future<List<CelestialBody>> getMoons(String id) async {
    var _snapshot =
        await planetsPath.document(id).collection('moons').getDocuments();
    return _snapshot.documents
        .map((document) => CelestialBody.fromJson(document))
        .toList();
  }

  final String id, imageUrl, name, description;
  final num population,
      aphelion,
      perihelion,
      period,
      speed,
      obliquity,
      radius,
      volume,
      mass,
      density,
      gravity,
      escapeVelocity,
      temperature,
      pressure;

  CelestialBody({
    this.id,
    this.imageUrl,
    this.name,
    this.description,
    this.population,
    this.aphelion,
    this.perihelion,
    this.period,
    this.speed,
    this.obliquity,
    this.radius,
    this.volume,
    this.mass,
    this.density,
    this.gravity,
    this.escapeVelocity,
    this.temperature,
    this.pressure,
  });

  factory CelestialBody.fromJson(DocumentSnapshot json) {
    return CelestialBody(
      id: json.documentID,
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      population: json['population'],
      aphelion: json['aphelion'],
      perihelion: json['perihelion'],
      period: json['period'],
      speed: json['speed'],
      obliquity: json['obliquity'],
      radius: json['radius'],
      volume: json['volume'],
      mass: json['mass'],
      density: json['density'],
      gravity: json['gravity'],
      escapeVelocity: json['escapeVelocity'],
      temperature: json['temperature'],
      pressure: json['pressure'],
    );
  }

  void removePlanet(CelestialBody planet) {
    final DocumentReference document = planetsPath.document(planet.id);
    document.delete();
    notifyListeners();
  }

  void addPlanet(CelestialBody celestialBody) {
    final DocumentReference document = planetsPath.document();
    document.setData(<String, dynamic>{
      'imageUrl': celestialBody.imageUrl,
      'name': celestialBody.name,
      'description': celestialBody.description,
      'aphelion': celestialBody.aphelion,
      'perihelion': celestialBody.perihelion,
      'period': celestialBody.period,
      'speed': celestialBody.speed,
      'obliquity': celestialBody.obliquity,
      'radius': celestialBody.radius,
      'volume': celestialBody.volume,
      'mass': celestialBody.mass,
      'density': celestialBody.density,
      'gravity': celestialBody.gravity,
      'escapeVelocity': celestialBody.escapeVelocity,
      'temperature': celestialBody.temperature,
      'pressure': celestialBody.pressure,
    });
    notifyListeners();
  }

  void addMoon(String id, CelestialBody celestialBody) {
    final DocumentReference document =
        planetsPath.document(id).collection('moons').document();
    document.setData(<String, dynamic>{
      'imageUrl': celestialBody.imageUrl,
      'name': celestialBody.name,
      'description': celestialBody.description,
      'aphelion': celestialBody.aphelion,
      'perihelion': celestialBody.perihelion,
      'period': celestialBody.period,
      'speed': celestialBody.speed,
      'obliquity': celestialBody.obliquity,
      'radius': celestialBody.radius,
      'volume': celestialBody.volume,
      'mass': celestialBody.mass,
      'density': celestialBody.density,
      'gravity': celestialBody.gravity,
      'escapeVelocity': celestialBody.escapeVelocity,
      'temperature': celestialBody.temperature,
      'pressure': celestialBody.pressure,
    });
    notifyListeners();
  }

  void editPlanet(CelestialBody celestialBody) {
    final DocumentReference document = planetsPath.document(celestialBody.id);
    document.updateData(<String, dynamic>{
      'imageUrl': celestialBody.imageUrl,
      'name': celestialBody.name,
      'description': celestialBody.description,
      'aphelion': celestialBody.aphelion,
      'perihelion': celestialBody.perihelion,
      'period': celestialBody.period,
      'speed': celestialBody.speed,
      'obliquity': celestialBody.obliquity,
      'radius': celestialBody.radius,
      'volume': celestialBody.volume,
      'mass': celestialBody.mass,
      'density': celestialBody.density,
      'gravity': celestialBody.gravity,
      'escapeVelocity': celestialBody.escapeVelocity,
      'temperature': celestialBody.temperature,
      'pressure': celestialBody.pressure,
    });
    notifyListeners();
  }

  void editMoon(String id, CelestialBody celestialBody) {
    final DocumentReference document =
        planetsPath.document(id).collection('moons').document(celestialBody.id);
    document.updateData(<String, dynamic>{
      'imageUrl': celestialBody.imageUrl,
      'name': celestialBody.name,
      'description': celestialBody.description,
      'aphelion': celestialBody.aphelion,
      'perihelion': celestialBody.perihelion,
      'period': celestialBody.period,
      'speed': celestialBody.speed,
      'obliquity': celestialBody.obliquity,
      'radius': celestialBody.radius,
      'volume': celestialBody.volume,
      'mass': celestialBody.mass,
      'density': celestialBody.density,
      'gravity': celestialBody.gravity,
      'escapeVelocity': celestialBody.escapeVelocity,
      'temperature': celestialBody.temperature,
      'pressure': celestialBody.pressure,
    });
    notifyListeners();
  }

  CollectionReference get moonsPath =>
      planetsPath.document(id).collection('moons');

  String get getPopulation =>
      'Population: ${NumberFormat.decimalPattern().format(population)}';

  String get getAphelion =>
      '${NumberFormat.decimalPattern().format(aphelion)} ua';

  String get getPerihelion =>
      '${NumberFormat.decimalPattern().format(perihelion)} ua';

  String get getPeriod =>
      '${NumberFormat.decimalPattern().format(period)} days';

  String get getSpeed => '${NumberFormat.decimalPattern().format(speed)} km/s';

  String get getObliquity =>
      '${NumberFormat.decimalPattern().format(obliquity)}°';

  String get getRadius => '${NumberFormat.decimalPattern().format(radius)} km';

  String get getVolume =>
      '${NumberFormat.scientificPattern().format(volume)} km³';

  String get getMass => '${NumberFormat.scientificPattern().format(mass)} kg';

  String get getDensity =>
      '${NumberFormat.decimalPattern().format(density)} g/cm³';

  String get getGravity =>
      '${NumberFormat.decimalPattern().format(gravity)} m/s²';

  String get getEscapeVelocity =>
      '${NumberFormat.decimalPattern().format(escapeVelocity)} km/s';

  String get getTemperature =>
      '${NumberFormat.decimalPattern().format(temperature)} K';

  String get getPressure =>
      '${NumberFormat.decimalPattern().format(pressure)} Pa';
}
