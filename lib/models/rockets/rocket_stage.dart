import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

abstract class Stage {
  final bool reusable;
  final num engines, fuelAmount, burnTime, thrustSea, thrustVacuum;

  Stage({
    this.reusable,
    this.engines,
    this.fuelAmount,
    this.burnTime,
    this.thrustSea,
    this.thrustVacuum,
  });

  String getFuelAmount(context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.fuel_amount_tons',
        {'tons': NumberFormat.decimalPattern().format(fuelAmount)},
      );

  String getEngines(context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.engines_number',
        {'number': engines.toString()},
      );

  String getBurnTime(context) => burnTime == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(burnTime)} s';

  String get getThrustSea =>
      '${NumberFormat.decimalPattern().format(thrustSea)} kN';

  String get getThrustVacuum =>
      '${NumberFormat.decimalPattern().format(thrustVacuum)} kN';
}

class FirstStage extends Stage {
  FirstStage({
    reusable,
    engines,
    fuelAmount,
    burnTime,
    thrustSea,
    thrustVacuum,
  }) : super(
          reusable: reusable,
          engines: engines,
          fuelAmount: fuelAmount,
          burnTime: burnTime,
          thrustSea: thrustSea,
          thrustVacuum: thrustVacuum,
        );
  factory FirstStage.fromJson(Map<String, dynamic> json) {
    return FirstStage(
      reusable: json['reusable'],
      engines: json['engines'],
      fuelAmount: json['fuel_amount_tons'],
      burnTime: json['burn_time_sec'],
      thrustSea: json['thrust_sea_level']['kN'],
      thrustVacuum: json['thrust_vacuum']['kN'],
    );
  }
}

class SecondStage extends Stage {
  final List fairingDimensions;

  SecondStage({
    reusable,
    engines,
    fuelAmount,
    burnTime,
    thrustVacuum,
    this.fairingDimensions,
  }) : super(
          reusable: reusable,
          engines: engines,
          fuelAmount: fuelAmount,
          burnTime: burnTime,
          thrustVacuum: thrustVacuum,
        );
  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      reusable: json['reusable'],
      engines: json['engines'],
      fuelAmount: json['fuel_amount_tons'],
      burnTime: json['burn_time_sec'],
      thrustVacuum: json['thrust']['kN'],
      fairingDimensions: [
        json['payloads']['composite_fairing']['height']['meters'],
        json['payloads']['composite_fairing']['diameter']['meters'],
      ],
    );
  }

  String fairingHeight(context) => fairingDimensions[0] == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[0])} m';

  String fairingDiameter(context) => fairingDimensions[1] == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[1])} m';
}
