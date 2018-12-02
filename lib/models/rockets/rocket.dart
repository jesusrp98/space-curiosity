import 'package:flutter_i18n/flutter_i18n.dart';

import 'second_stage.dart';

/// ROCKET CLASS
/// This class is used in the Launch class, to represent a rocket object. It has
/// a list of cores, and a second stage.
class Rocket {
  final String id, name, type;
  final List<Core> firstStage;
  final SecondStage secondStage;
  final bool hasFairing;
  final Fairing fairing;

  Rocket({
    this.id,
    this.name,
    this.type,
    this.firstStage,
    this.secondStage,
    this.hasFairing,
    this.fairing,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['rocket_id'],
      name: json['rocket_name'],
      type: json['rocket_type'],
      firstStage: (json['first_stage']['cores'] as List)
          .map((core) => Core.fromJson(core))
          .toList(),
      secondStage: SecondStage.fromJson(json['second_stage']),
      hasFairing: json['fairings'] != null,
      fairing:
          json['fairings'] == null ? null : Fairing.fromJson(json['fairings']),
    );
  }

  bool get isHeavy => firstStage.length != 1;
}

class Core {
  final String id, landingType, landingZone;
  final bool reused, landingSuccess, landingIntent;
  final int block, flights;

  Core({
    this.id,
    this.landingType,
    this.landingZone,
    this.reused,
    this.landingSuccess,
    this.landingIntent,
    this.block,
    this.flights,
  });

  factory Core.fromJson(Map<String, dynamic> json) {
    return Core(
      id: json['core_serial'],
      landingType: json['landing_type'],
      landingZone: json['landing_vehicle'],
      reused: json['reused'],
      landingSuccess: json['land_success'],
      landingIntent: json['landing_intent'],
      block: json['block'],
      flights: json['flight'],
    );
  }

  String getId(context) =>
      id ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getLandingType(context) =>
      landingType ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getLandingZone(context) =>
      landingZone ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getBlock(context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  String getFlights(context) => flights == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : flights.toString();
}

/// FAIRING CLASS
/// This class represent a detailed fairing, including the recovery process.
class Fairing {
  final bool reused, recoveryAttempt, recoverySuccess;
  final String ship;

  Fairing({
    this.reused,
    this.recoveryAttempt,
    this.recoverySuccess,
    this.ship,
  });

  factory Fairing.fromJson(Map<String, dynamic> json) {
    return Fairing(
      reused: json['reused'],
      recoveryAttempt: json['recovery_attempt'],
      recoverySuccess: json['recovered'],
      ship: json['ship'],
    );
  }
}
