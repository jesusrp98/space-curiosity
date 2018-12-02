import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

/// STAGE MODEL
/// General information about a specific stage of a Falcon rocket.
abstract class Stage {
  final bool reusable;
  final num engines, fuelAmount, thrustSea, thrustVacuum;

  Stage({
    this.reusable,
    this.engines,
    this.fuelAmount,
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
    thrustSea,
    thrustVacuum,
  }) : super(
          reusable: reusable,
          engines: engines,
          fuelAmount: fuelAmount,
          thrustSea: thrustSea,
          thrustVacuum: thrustVacuum,
        );
  factory FirstStage.fromJson(Map<String, dynamic> json) {
    return FirstStage(
      reusable: json['reusable'],
      engines: json['engines'],
      fuelAmount: json['fuel_amount_tons'],
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
    thrustVacuum,
    this.fairingDimensions,
  }) : super(
          reusable: reusable,
          engines: engines,
          fuelAmount: fuelAmount,
          thrustVacuum: thrustVacuum,
        );
  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      reusable: json['reusable'],
      engines: json['engines'],
      fuelAmount: json['fuel_amount_tons'],
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
