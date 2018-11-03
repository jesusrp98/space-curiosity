import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';

/// LAUNCHPAD CLASS
/// This class represents a real launchpad used in a SpaceX mission,
/// with all its details.
class LaunchpadModel extends QuerryModel {
  final String id;

  LaunchpadModel(this.id);

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
  final int attemptedLandings, successfulLandings;

  Launchpad({
    this.name,
    this.status,
    this.location,
    this.state,
    this.details,
    this.url,
    this.coordinates,
    this.attemptedLandings,
    this.successfulLandings,
  });

  factory Launchpad.fromJson(Map<String, dynamic> json) {
    return Launchpad(
      name: json['site_name_long'],
      status: json['status'],
      location: json['location']['name'],
      state: json['location']['region'],
      details: json['details'],
      url: json['wikiepdia'],
      coordinates: [
        json['location']['latitude'],
        json['location']['longitude'],
      ],
      attemptedLandings: json['attempted_landings'],
      successfulLandings: json['successful_landings'],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates => (coordinates[0].toStringAsPrecision(5) +
      ',  ' +
      coordinates[1].toStringAsPrecision(5));

  String get getAttemptedLandings => attemptedLandings.toString();

  String get getSuccessfulLandings => successfulLandings.toString();
}