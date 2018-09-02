import 'package:cloud_firestore/cloud_firestore.dart';

class Planet {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final num aphelion;
  final num perihelion;
  final String orbit;
  final num period;
  final num speed;
  final num inclination;
  final num radius;
  final num volume;
  final num mass;
  final num density;
  final num gravity;
  final num escapeVelocity;
  final num temperature;
  final num pressure;

  Planet({
    this.id,
    this.imageUrl,
    this.name,
    this.description,
    this.aphelion,
    this.perihelion,
    this.orbit,
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

  factory Planet.fromJson(DocumentSnapshot json) {
    return Planet(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      aphelion: json['aphelion'],
      perihelion: json['perihelion'],
      orbit: json['orbit'],
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
