import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';

/// LAUNCHPAD MODEL
/// Details about a specific launchpad,
/// where rockets are launched
class LaunchpadModel extends QuerryModel {
  // Launchpad id: ccafs_slc_40
  // Launchpad name: Cape Canaveral Air Force Station Space Launch Complex 40
  final String id, name;

  LaunchpadModel(this.id, this.name);

  @override
  Future loadData() async {
    // Get item by http call
    response = await http.get(Url.launchpadDialog + id);

    // Clear old data
    clearItems();

    // Added parsed item
    items.add(Launchpad.fromJson(json.decode(response.body)));

    // Finished with loading data
    loadingState(false);
  }

  Launchpad get launchpad => items[0];
}

class Launchpad {
  final String name, status, location, state, details, url;
  final List<double> coordinates;
  final List vehicles;
  final int attemptedLaunches, successfulLaunches;

  Launchpad({
    this.name,
    this.status,
    this.location,
    this.state,
    this.details,
    this.url,
    this.coordinates,
    this.vehicles,
    this.attemptedLaunches,
    this.successfulLaunches,
  });

  factory Launchpad.fromJson(Map<String, dynamic> json) {
    return Launchpad(
      name: json['site_name_long'],
      status: json['status'],
      location: json['location']['name'],
      state: json['location']['region'],
      details: json['details'],
      url: json['wikipedia'],
      coordinates: [
        json['location']['latitude'],
        json['location']['longitude'],
      ],
      vehicles: json['vehicles_launched'],
      attemptedLaunches: json['attempted_launches'],
      successfulLaunches: json['successful_launches'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates =>
      '${coordinates[0].toStringAsPrecision(5)},  ${coordinates[1].toStringAsPrecision(5)}';

  String get getSuccessfulLaunches => '$successfulLaunches/$attemptedLaunches';
}
