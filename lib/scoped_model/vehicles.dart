import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_news/models/rockets/capsule_info.dart';
import 'package:space_news/models/rockets/roadster.dart';
import 'package:space_news/models/rockets/rocket_info.dart';
import 'package:space_news/models/rockets/ship_info.dart';
import 'package:space_news/scoped_model/general_model.dart';
import 'package:space_news/util/url.dart';

class VehiclesModel extends GeneralModel {
  @override
  Future loadData() async {
    loadingState(true);

    final rocketsResponse = await http.get(Url.rocketList);
    final capsulesResponse = await http.get(Url.capsuleList);
    final roadsterResponse = await http.get(Url.roadsterPage);
    final shipsResponse = await http.get(Url.shipsList);

    List rocketsJson = json.decode(rocketsResponse.body);
    List capsulesJson = json.decode(capsulesResponse.body);
    List shipsJson = json.decode(shipsResponse.body);

    list.add(Roadster.fromJson(json.decode(roadsterResponse.body)));
    list.addAll(
        capsulesJson.map((capsule) => CapsuleInfo.fromJson(capsule)).toList());
    list.addAll(
        rocketsJson.map((rocket) => RocketInfo.fromJson(rocket)).toList());
    list.addAll(shipsJson.map((rocket) => ShipInfo.fromJson(rocket)).toList());

    loadingState(false);
  }
}
