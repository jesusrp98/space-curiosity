import 'package:fb_firestore/classes/snapshot.dart';
import 'package:fb_firestore/fb_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../../util/photos.dart';
import '../models.dart';

/// ISS HOME MODEL
/// Shows main details about the ISS project, including dimensions, cost...
class IssHomeModel extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
    // Get items from Firebase
    var response = await FbFirestore.getDocs('iss');

    // Add parsed items
    items.addAll(
      response
          .map((document) => IssHome.fromDocument(document))
          .toList(),
    );

    // Add photos & shuffle them
    if (photos.isEmpty) {
      photos.addAll(IssPhotos.iss);
      photos.shuffle();
    }

    // Finished loading data
    finishLoading();
  }

  IssHome get issHome => getItem(0);

  String launchedTitle(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.launched.title',
        {'year': issHome.launchDate.year.toString()},
      );

  String launchedBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.launched.body',
        {'date': issHome.getLaunchDate, 'years': issHome.getYearsInOrbit},
      );

  String altitudeBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.altitude.body',
        {'height': issHome.getAltitude, 'velocity': issHome.getSpeed},
      );

  String orbitBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.orbit.body',
        {'period': issHome.getPeriod, 'orbits': issHome.getOrbits},
      );

  String projectTitle(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.project.body',
        {
          'countries': issHome.countries.toString(),
          'cost': issHome.getProjectCost
        },
      );

  String numbersBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.numbers.body',
        {'days': issHome.getDaysInOrbit, 'orbits': issHome.getTotalOrbits},
      );

  String specificationsBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.specifications.body',
        {
          'length': issHome.getLength,
          'width': issHome.getWidth,
          'mass': issHome.getWeight
        },
      );
}

class IssHome {
  final DateTime launchDate;
  final num altitude,
      orbitTime,
      projectCost,
      countries,
      length,
      width,
      weight,
      speed;

  IssHome({
    this.launchDate,
    this.altitude,
    this.orbitTime,
    this.projectCost,
    this.countries,
    this.length,
    this.width,
    this.weight,
    this.speed,
  });

  factory IssHome.fromDocument(FbDocumentSnapshot document) {
    final data = document.data;
    return IssHome(
      launchDate: DateTime.parse(data['launch_year']),
      altitude: data['altitude'],
      orbitTime: data['orbit_time'],
      projectCost: data['project_cost'],
      countries: data['project_countries'],
      length: data['specs_length'],
      width: data['specs_width'],
      weight: data['specs_weight'],
      speed: data['speed'],
    );
  }

  int get _daysSinceLaunch => DateTime.now().difference(launchDate).inDays;

  String get getLaunchDate => DateFormat.yMMMMd().format(launchDate);

  String get getYearsInOrbit => (_daysSinceLaunch / 356).toStringAsPrecision(2);

  String get getAltitude =>
      '${NumberFormat.decimalPattern().format(altitude)} km';

  String get getPeriod =>
      NumberFormat.decimalPattern().format((orbitTime / 60).round());

  String get getOrbits => NumberFormat.decimalPattern()
      .format((Duration.minutesPerDay / (orbitTime / 60)).round());

  String get getProjectCost =>
      NumberFormat.compactSimpleCurrency(decimalDigits: 0).format(projectCost);

  String get getLength =>
      '${NumberFormat.decimalPattern().format(length.round())} m';

  String get getWidth =>
      '${NumberFormat.decimalPattern().format(width.round())} m';

  String get getWeight =>
      '${NumberFormat.decimalPattern().format(weight.round())} kg';

  String get getSpeed =>
      '${NumberFormat.decimalPattern().format(speed.round())} km/s';

  String get getDaysInOrbit =>
      NumberFormat.decimalPattern().format(_daysSinceLaunch);

  String get getTotalOrbits => NumberFormat.decimalPattern().format(
        (_daysSinceLaunch * Duration.minutesPerDay / (orbitTime / 60)).round(),
      );
}
