import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weight.g.dart';

@JsonSerializable()
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

  String get planetWeightFormatLbs => planetWeight.toStringAsFixed(2) + " lbs";
  String get planetWeightFormatKg =>
      (planetWeight / 2.2046).toStringAsFixed(2) + " kg";

  @override
  String toString() => 'Post { Planet: $planet }';

  factory Calculator.fromJson(Map<String, dynamic> json) =>
      _$CalculatorFromJson(json);

  Map<String, dynamic> toJson() => _$CalculatorToJson(this);
}
