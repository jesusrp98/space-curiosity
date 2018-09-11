import 'package:cloud_firestore/cloud_firestore.dart';

import 'celestial_body.dart';

class Planet extends CelestialBody {
  final List<CelestialBody> moons;

  Planet({
    id,
    imageUrl,
    name,
    description,
    aphelion,
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
    pressure,
    this.moons,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          name: name,
          description: description,
          aphelion: aphelion,
          perihelion: perihelion,
          period: period,
          speed: speed,
          inclination: inclination,
          radius: radius,
          volume: volume,
          mass: mass,
          density: density,
          gravity: gravity,
          escapeVelocity: escapeVelocity,
          temperature: temperature,
        );

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
      moons: (json['moons'] as List)
          .map((moon) => CelestialBody.fromJson(moon))
          .toList(),
    );
  }
}
