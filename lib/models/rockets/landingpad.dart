import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';

/// LAUNCHPAD CLASS
/// This class represents a real launchpad used in a SpaceX mission,
/// with all its details.
class LandingpadModel extends QuerryModel {
  final String id;

  LandingpadModel(this.id);

  @override
  Future loadData() async {
    response = await http.get(Url.launchpadDialog + id);
    clearLists();

    items.add(Landingpad.fromJson(json.decode(response.body)));

    loadingState(false);
  }

  Landingpad get launchpad => items[0];
}

class Landingpad {
  final String name, status, location, state, details;
  final List<double> coordinates;

  Landingpad({
    this.name,
    this.status,
    this.location,
    this.state,
    this.details,
    this.coordinates,
  });

  factory Landingpad.fromJson(Map<String, dynamic> json) {
    return Landingpad(
      name: json['site_name_long'],
      status: json['status'],
      location: json['location']['name'],
      state: json['location']['region'],
      details: json['details'],
      coordinates: [
        json['location']['latitude'],
        json['location']['longitude'],
      ],
    );
  }

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String get getCoordinates => (coordinates[0].toStringAsPrecision(5) +
      ',  ' +
      coordinates[1].toStringAsPrecision(5));
}
