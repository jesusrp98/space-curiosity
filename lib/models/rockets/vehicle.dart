import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../util/url.dart';
import '../querry_model.dart';
import 'capsule_info.dart';
import 'roadster.dart';
import 'rocket_info.dart';
import 'ship_info.dart';

/// VEHICLE CLASS
/// Abstract class that represents a real vehicle used by SpaceX. It can be
/// a rocket or a capsule, because they have similar base characteristics.
class VehiclesModel extends QuerryModel {
  @override
  Future loadData() async {
    final rocketsResponse = await http.get(Url.rocketList);
    final capsulesResponse = await http.get(Url.capsuleList);
    final roadsterResponse = await http.get(Url.roadsterPage);
    final shipsResponse = await http.get(Url.shipsList);

    List rocketsJson = json.decode(rocketsResponse.body);
    List capsulesJson = json.decode(capsulesResponse.body);
    List shipsJson = json.decode(shipsResponse.body);
    clearLists();

    items.add(Roadster.fromJson(json.decode(roadsterResponse.body)));
    items.addAll(
        capsulesJson.map((capsule) => CapsuleInfo.fromJson(capsule)).toList());
    items.addAll(
        rocketsJson.map((rocket) => RocketInfo.fromJson(rocket)).toList());
    items.addAll(shipsJson.map((rocket) => ShipInfo.fromJson(rocket)).toList());

    List<int> randomList = List<int>.generate(getSize, (index) => index);
    randomList.shuffle();
    randomList
        .sublist(0, 5)
        .forEach((index) => photos.add(getItem(index).getRandomPhoto));

    loadingState(false);
  }
}

abstract class Vehicle {
  final String id, name, type, description, url;
  final num height, diameter, mass;
  final bool active, reusable;
  final DateTime firstFlight;
  final List photos;

  Vehicle({
    this.id,
    this.name,
    this.type,
    this.description,
    this.url,
    this.height,
    this.diameter,
    this.mass,
    this.active,
    this.reusable,
    this.firstFlight,
    this.photos,
  });

  String get subtitle;

  String get getProfilePhoto => (hasImages) ? photos[0] : Url.defaultImage;

  int get getPhotosCount => photos.length;

  String get getRandomPhoto => photos[Random().nextInt(getPhotosCount)];

  String getPhoto(index) => photos[index];

  bool get hasImages => photos.isNotEmpty;

  String get getHeight => '${NumberFormat.decimalPattern().format(height)} m';

  String get getDiameter =>
      '${NumberFormat.decimalPattern().format(diameter)} m';

  String get getMass => mass == null
      ? 'Unknown'
      : '${NumberFormat.decimalPattern().format(mass)} kg';

  String get getFirstFlight => DateFormat.yMMMM().format(firstFlight);

  String get getFullFirstFlight => DateFormat.yMMMMd().format(firstFlight);

  String get firstLaunched {
    if (!DateTime.now().isAfter(firstFlight))
      return 'Scheduled to $getFirstFlight';
    else
      return 'First launched on $getFirstFlight';
  }
}
