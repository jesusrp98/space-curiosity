import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_news/models/rockets/capsule_info.dart';
import 'package:space_news/models/rockets/roadster.dart';
import 'package:space_news/models/rockets/rocket_info.dart';
import 'package:space_news/models/rockets/ship_info.dart';
import 'package:space_news/models/rockets/vehicle.dart';
import 'package:space_news/util/url.dart';
import 'package:scoped_model/scoped_model.dart';

class VehiclesModel extends Model {
  List<Vehicle> _vehicles = List();
  bool _isLoading = true;

  Future refresh() async {
    await loadData();
    notifyListeners();
  }

  Future loadData() async {
    final rocketsResponse = await http.get(Url.rocketList);
    final capsulesResponse = await http.get(Url.capsuleList);
    final roadsterResponse = await http.get(Url.roadsterPage);
    final shipsResponse = await http.get(Url.shipsList);

    List rocketsJson = json.decode(rocketsResponse.body);
    List capsulesJson = json.decode(capsulesResponse.body);
    List shipsJson = json.decode(shipsResponse.body);

    _vehicles.add(Roadster.fromJson(json.decode(roadsterResponse.body)));
    _vehicles.addAll(
        capsulesJson.map((capsule) => CapsuleInfo.fromJson(capsule)).toList());
    _vehicles.addAll(
        rocketsJson.map((rocket) => RocketInfo.fromJson(rocket)).toList());
    _vehicles
        .addAll(shipsJson.map((rocket) => ShipInfo.fromJson(rocket)).toList());

    notifyListeners();
  }

  bool get isLoading => _isLoading;

  List<Vehicle> get vehicles => _vehicles;
}
