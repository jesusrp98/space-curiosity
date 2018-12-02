import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

// ??
class SecondStage {
  final int block;
  final List<Payload> payloads;

  SecondStage({this.block, this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'],
      payloads: (json['payloads'] as List)
          .map((payload) => Payload.fromJson(payload))
          .toList(),
    );
  }

  String getBlock(context) => block == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : FlutterI18n.translate(
          context,
          'spacex.other.block',
          {'block': block.toString()},
        );

  Payload getPayload(int index) => payloads[index];

  int get getNumberPayload => payloads.length;
}

// ??
class Payload {
  final String id, capsuleSerial, customer, nationality, manufacturer, orbit;
  final bool reused;
  final num mass;

  Payload({
    this.id,
    this.capsuleSerial,
    this.customer,
    this.nationality,
    this.manufacturer,
    this.orbit,
    this.reused,
    this.mass,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['payload_id'],
      capsuleSerial: json['cap_serial'],
      customer: json['customers'][0],
      nationality: json['nationality'],
      manufacturer: json['manufacturer'],
      orbit: json['orbit'],
      reused: json['reused'],
      mass: json['payload_mass_kg'],
    );
  }

  String getId(context) =>
      id ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getCapsuleSerial(context) =>
      capsuleSerial ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getCustomer(context) =>
      customer ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getNationality(context) =>
      nationality ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getManufacturer(context) =>
      manufacturer ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getOrbit(context) =>
      orbit ?? FlutterI18n.translate(context, 'spacex.other.unknown');

  String getMass(context) => mass == null
      ? FlutterI18n.translate(context, 'spacex.other.unknown')
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  bool get isNasaPayload =>
      customer == 'NASA (CCtCap)' || customer == 'NASA (CRS)';
}
