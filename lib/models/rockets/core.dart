import 'package:flutter_i18n/flutter_i18n.dart';

/// CORE CLASS
/// This class is used in conjunction with the 'launch.dart' class, to retrieve
/// core information from the rocket used in a specific mission.
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
