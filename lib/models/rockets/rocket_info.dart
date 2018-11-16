import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import 'vehicle.dart';

/// ROCKET INFO CLASS
/// This class represents a model of a rocket, like Falcon 9 or BFR, with
/// all its specifications in place.
class RocketInfo extends Vehicle {
  final num stages,
      launchCost,
      successRate,
      engineThrustSea,
      engineThrustVacuum,
      thrustToWeight;
  final List<PayloadWeight> payloadWeights;
  final String engine, fuel, oxidizer;
  final List<num> engineConfiguration, fairingDimensions;

  RocketInfo({
    id,
    name,
    type,
    description,
    url,
    height,
    diameter,
    mass,
    active,
    reusable,
    firstFlight,
    photos,
    this.stages,
    this.launchCost,
    this.successRate,
    this.engineThrustSea,
    this.engineThrustVacuum,
    this.thrustToWeight,
    this.payloadWeights,
    this.engine,
    this.fuel,
    this.oxidizer,
    this.engineConfiguration,
    this.fairingDimensions,
  }) : super(
          id: id,
          name: name,
          type: type,
          description: description,
          url: url,
          height: height,
          diameter: diameter,
          mass: mass,
          active: active,
          reusable: reusable,
          firstFlight: firstFlight,
          photos: photos,
        );

  factory RocketInfo.fromJson(Map<String, dynamic> json) {
    return RocketInfo(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      description: json['description'],
      url: json['wikipedia'],
      height: json['height']['meters'],
      diameter: json['diameter']['meters'],
      mass: json['mass']['kg'],
      active: json['active'],
      reusable: json['first_stage']['reusable'],
      firstFlight: DateTime.parse(json['first_flight']),
      photos: json['flickr_images'],
      stages: json['stages'],
      launchCost: json['cost_per_launch'],
      successRate: json['success_rate_pct'],
      engineThrustSea: json['engines']['thrust_sea_level']['kN'],
      engineThrustVacuum: json['engines']['thrust_vacuum']['kN'],
      thrustToWeight: json['engines']['thrust_to_weight'],
      payloadWeights: (json['payload_weights'] as List)
          .map((payloadWeight) => PayloadWeight.fromJson(payloadWeight))
          .toList(),
      engine: json['engines']['type'] + ' ' + json['engines']['version'],
      fuel: json['engines']['propellant_2'],
      oxidizer: json['engines']['propellant_1'],
      fairingDimensions: [
        json['second_stage']['payloads']['composite_fairing']['height']
            ['meters'],
        json['second_stage']['payloads']['composite_fairing']['diameter']
            ['meters'],
      ],
      engineConfiguration: [
        json['first_stage']['engines'],
        json['second_stage']['engines'],
      ],
    );
  }

  String subtitle(context) => firstLaunched(context);

  String getStages(context) => FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.specifications.stages',
        {'stages': stages.toString()},
      );

  String get getLaunchCost =>
      NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(launchCost);

  String getSuccessRate(context) => (DateTime.now().isAfter(firstFlight))
      ? NumberFormat.percentPattern().format(successRate / 100)
      : FlutterI18n.translate(context, 'spacex.other.no_data');

  String get getEngineThrustSea =>
      '${NumberFormat.decimalPattern().format(engineThrustSea)} kN';

  String get getEngineThrustVacuum =>
      '${NumberFormat.decimalPattern().format(engineThrustVacuum)} kN';

  String getThrustToWeight(context) => thrustToWeight == null
      ? FlutterI18n.translate(context, 'spacex.other.unkown')
      : NumberFormat.decimalPattern().format(thrustToWeight);

  String get getEngine => '${engine[0].toUpperCase()}${engine.substring(1)}';

  String get getFuel => '${fuel[0].toUpperCase()}${fuel.substring(1)}';

  String get getOxidizer =>
      '${oxidizer[0].toUpperCase()}${oxidizer.substring(1)}';

  String fairingHeight(context) => fairingDimensions[0] == null
      ? FlutterI18n.translate(context, 'spacex.other.unkown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[0])} m';

  String fairingDiameter(context) => fairingDimensions[1] == null
      ? FlutterI18n.translate(context, 'spacex.other.unkown')
      : '${NumberFormat.decimalPattern().format(fairingDimensions[1])} m';

  String get firstStageEngines => engineConfiguration[0].toString();

  String get secondStageEngines => engineConfiguration[1].toString();
}

class PayloadWeight {
  final String name;
  final int mass;

  PayloadWeight(this.name, this.mass);

  factory PayloadWeight.fromJson(Map<String, dynamic> json) {
    return PayloadWeight(json['name'], json['kg']);
  }

  String get getMass => '${NumberFormat.decimalPattern().format(mass)} kg';
}
