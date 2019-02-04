import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../querry_model.dart';

class IssHomeModel extends QuerryModel {
  @override
  Future loadData() async {
    // Get items from Firebase
    response = await Firestore.instance.collection('iss').getDocuments();

    // Clear old data
    clearItems();

    // // Add parsed items
    items.addAll(response.documents
        .map((document) => IssHome.fromDocument(document))
        .toList());

    // Finished loading data
    setLoading(false);
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

  factory IssHome.fromDocument(DocumentSnapshot document) {
    return IssHome(
      launchDate: DateTime.parse(document['launch_year']),
      altitude: document['altitude'],
      orbitTime: document['orbit_time'],
      projectCost: document['project_cost'],
      countries: document['project_countries'],
      length: document['specs_length'],
      width: document['specs_width'],
      weight: document['specs_weight'],
      speed: document['speed'],
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
      '${NumberFormat.decimalPattern().format(speed.round())} km/h';

  String get getDaysInOrbit =>
      NumberFormat.decimalPattern().format(_daysSinceLaunch);

  String get getTotalOrbits => NumberFormat.decimalPattern().format(
        (_daysSinceLaunch * Duration.minutesPerDay / (orbitTime / 60)).round(),
      );
}
