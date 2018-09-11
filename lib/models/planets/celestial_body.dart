import 'package:cloud_firestore/cloud_firestore.dart';

import 'planet.dart';

class CelestialBody extends Planet {
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
}
