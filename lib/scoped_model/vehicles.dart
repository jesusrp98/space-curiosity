import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/rockets/capsule_info.dart';
import '../models/rockets/roadster.dart';
import '../models/rockets/rocket_info.dart';
import '../models/rockets/ship_info.dart';
import '../util/url.dart';
import 'general_model.dart';

class VehiclesModel extends GeneralModel {
  @override
  Future loadData() async {
    final rocketsResponse = await http.get(Url.rocketList);
    final capsulesResponse = await http.get(Url.capsuleList);
    final roadsterResponse = await http.get(Url.roadsterPage);
    final shipsResponse = await http.get(Url.shipsList);

    List rocketsJson = json.decode(rocketsResponse.body);
    List capsulesJson = json.decode(capsulesResponse.body);
    List shipsJson = json.decode(shipsResponse.body);

    list.clear();
    list.add(Roadster.fromJson(json.decode(roadsterResponse.body)));
    list.addAll(
        capsulesJson.map((capsule) => CapsuleInfo.fromJson(capsule)).toList());
    list.addAll(
        rocketsJson.map((rocket) => RocketInfo.fromJson(rocket)).toList());
    list.addAll(shipsJson.map((rocket) => ShipInfo.fromJson(rocket)).toList());

    loadingState(false);
  }
}
