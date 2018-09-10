import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Planet {
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
    @required this.id,
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
}
