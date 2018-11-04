import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';
import 'vehicle_details.dart';

/// CAPSULE DETAILS CLASS
/// This class represents a real capsule used in a CRS mission,
/// with all its details.
class CapsuleModel extends QuerryModel {
  final String id;

  CapsuleModel(this.id);

  @override
  Future loadData() async {
    response = await http.get(Url.capsuleDialog + id);
    clearLists();

    items.add(CapsuleDetails.fromJson(json.decode(response.body)));

    photos.addAll(Url.spacexCapsuleDialog);
    photos.shuffle();

    loadingState(false);
  }

  CapsuleDetails get capsule => items[0];
}

class CapsuleDetails extends VehicleDetails {
  final String name;
  final int landings;

  CapsuleDetails({
    serial,
    status,
    details,
    firstLaunched,
    missions,
    this.name,
    this.landings,
  }) : super(
          serial: serial,
          status: status,
          details: details,
          firstLaunched: firstLaunched,
          missions: missions,
        );

  factory CapsuleDetails.fromJson(Map<String, dynamic> json) {
    return CapsuleDetails(
      serial: json['capsule_serial'],
      status: json['status'],
      details: json['details'],
      firstLaunched: DateTime.parse(json['original_launch']).toLocal(),
      missions: json['missions']
          .map((mission) => DetailsMission.fromJson(mission))
          .toList(),
      name: json['type'],
      landings: json['landings'],
    );
  }

  String get getDetails => details ?? 'This capsule has currently no details.';

  String get getLandings => landings.toString();
}
