import 'dart:async';

import 'package:fb_firestore/classes/index.dart';
import 'package:fb_firestore/fb_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models.dart';

enum BodyType { planet, celestialBody }

class PlanetsModel extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
    var response = await FbFirestore.getDocs('planets');

    items.addAll(
      response.map((document) => CelestialBody.fromJson(document)).toList(),
    );

    finishLoading();
  }
}

class CelestialBody extends ChangeNotifier {
  Future<List<CelestialBody>> getMoons(String id) async {
    var _snapshot = await FbFirestore.getDocs('planets/$id/moons');
    return _snapshot
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

  factory CelestialBody.fromJson(FbDocumentSnapshot json) {
    final data = json.data;
    return CelestialBody(
      id: json.documentId,
      imageUrl: data['imageUrl'],
      name: data['name'],
      description: data['description'],
      population: data['population'],
      aphelion: data['aphelion'],
      perihelion: data['perihelion'],
      period: data['period'],
      speed: data['speed'],
      obliquity: data['obliquity'],
      radius: data['radius'],
      volume: data['volume'],
      mass: data['mass'],
      density: data['density'],
      gravity: data['gravity'],
      escapeVelocity: data['escapeVelocity'],
      temperature: data['temperature'],
      pressure: data['pressure'],
    );
  }

  void removePlanet(CelestialBody planet) async {
    await FbFirestore.deleteDoc('planets/${planet.id}');
    notifyListeners();
  }

  void addPlanet(CelestialBody celestialBody) async {
    FbFirestore.editDoc('planets', <String, dynamic>{
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

  void addMoon(String id, CelestialBody celestialBody) async {
    await FbFirestore.editDoc('planets/$id/moons', <String, dynamic>{
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

  void editPlanet(CelestialBody celestialBody) async {
    await FbFirestore.editDoc(
      'planets',
      <String, dynamic>{
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
      },
      id: celestialBody.id,
    );
    notifyListeners();
  }

  void editMoon(String id, CelestialBody celestialBody) async {
    await FbFirestore.editDoc(
      'planets/$id/moons',
      <String, dynamic>{
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
      },
      id: celestialBody.id,
      update: true,
    );
    notifyListeners();
  }

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
