import 'package:equatable/equatable.dart';

class Calculator extends Equatable {
  final num weight;
  final num surfaceGravity;
  final String planet;

  Calculator({
    this.weight,
    this.planet,
    this.surfaceGravity,
  }) : super([weight, surfaceGravity, planet]);

  num get planetWeight => weight * surfaceGravity;

  String get planetWeightFormat => planetWeight.toStringAsFixed(2) + " lbs";

  @override
  String toString() => 'Post { Planet: $planet }';
}
