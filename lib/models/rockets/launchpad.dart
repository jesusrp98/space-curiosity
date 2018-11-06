import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';

/// LAUNCHPAD CLASS
/// This class represents a real launchpad used in a SpaceX mission,
/// with all its details.
class LaunchpadModel extends QuerryModel {
  final String id, name;

  LaunchpadModel(this.id, this.name);

  @override
  Future loadData() async {
    response = await http.get(Url.launchpadDialog + id);
    clearLists();

    items.add(Launchpad.fromJson(json.decode(response.body)));

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

  String get getCoordinates => (coordinates[0].toStringAsPrecision(5) +
      ',  ' +
      coordinates[1].toStringAsPrecision(5));

  String get getSuccessfulLaunches => '$successfulLaunches/$attemptedLaunches';
}
