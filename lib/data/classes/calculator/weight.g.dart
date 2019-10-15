// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Calculator _$CalculatorFromJson(Map<String, dynamic> json) {
  return Calculator(
    weight: json['weight'] as num,
    planet: json['planet'] as String,
    surfaceGravity: json['surfaceGravity'] as num,
  );
}

Map<String, dynamic> _$CalculatorToJson(Calculator instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'surfaceGravity': instance.surfaceGravity,
      'planet': instance.planet,
    };
