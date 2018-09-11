import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'planets.dart';

enum BodyType { planet, celestialBody }

class CelestialBody extends Model {
  List<CelestialBody> _moons;

  List<CelestialBody> get moons => _moons;

  set moons(List<CelestialBody> list) {
    _moons = moons;
    notifyListeners();
  }

  final String id, imageUrl, name, description;
  final num aphelion,
      perihelion,
      period,
      speed,
      inclination,
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
    this.aphelion,
    this.perihelion,
    this.period,
    this.speed,
    this.inclination,
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
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      aphelion: json['aphelion'],
      perihelion: json['perihelion'],
      period: json['period'],
      speed: json['speed'],
      inclination: json['inclination'],
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
      'id': document.documentID,
      'imageUrl': celestialBody.imageUrl,
      'name': celestialBody.name,
      'description': celestialBody.description,
      'aphelion': celestialBody.aphelion,
      'perihelion': celestialBody.perihelion,
      'period': celestialBody.period,
      'speed': celestialBody.speed,
      'inclination': celestialBody.inclination,
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
      'inclination': celestialBody.inclination,
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
}
