import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'planets.dart';

class Planet extends Model {
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

  Planet({
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

  Future<Planet> getPlanet(Planet planet) async {
    final DocumentSnapshot document =
        await planetsPath.document(planet.id).get();
    return Planet.fromJson(document);
  }

  factory Planet.fromJson(DocumentSnapshot json) {
    return Planet(
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

  void removePlanet(Planet planet) {
    final DocumentReference document = planetsPath.document(planet.id);
    document.delete();
    notifyListeners();
  }

  void addPlanet(Planet planet) {
    final DocumentReference document = planetsPath.document();
    document.setData(<String, dynamic>{
      'id': document.documentID,
      'imageUrl': planet.imageUrl,
      'name': planet.name,
      'description': planet.description,
      'aphelion': planet.aphelion,
      'perihelion': planet.perihelion,
      'period': planet.period,
      'speed': planet.speed,
      'inclination': planet.inclination,
      'radius': planet.radius,
      'volume': planet.volume,
      'mass': planet.mass,
      'density': planet.density,
      'gravity': planet.gravity,
      'escapeVelocity': planet.escapeVelocity,
      'temperature': planet.temperature,
      'pressure': planet.pressure,
    });
    notifyListeners();
  }

  void editPlanet(Planet planet) {
    final DocumentReference document = planetsPath.document(planet.id);
    document.updateData(<String, dynamic>{
      'imageUrl': planet.imageUrl,
      'name': planet.name,
      'description': planet.description,
      'aphelion': planet.aphelion,
      'perihelion': planet.perihelion,
      'period': planet.period,
      'speed': planet.speed,
      'inclination': planet.inclination,
      'radius': planet.radius,
      'volume': planet.volume,
      'mass': planet.mass,
      'density': planet.density,
      'gravity': planet.gravity,
      'escapeVelocity': planet.escapeVelocity,
      'temperature': planet.temperature,
      'pressure': planet.pressure,
    });
    notifyListeners();
  }
}
