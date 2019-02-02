import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../util/url.dart';
import '../querry_model.dart';
import 'astronauts.dart';
import 'current_location.dart';
import 'pass_time.dart';

class IssModel extends QuerryModel {
  Map<String, double> currentLocation;

  @override
  Future loadData() async {
    // Get items by http call & parse them
    response = await http.get(Url.issLocation);

    // Clear old data
    clearItems();

    items.add(IssLocation.fromJson(json.decode(response.body)));

    // Ask user about location
    // Parse if permission are granted
    try {
      // Get user's location
      currentLocation = await Location().getLocation();

      // Get items by http call & parse them
      response = await http.get(
        '${Url.issPassTimes}?lat=${currentLocation['latitude']}&lon=${currentLocation['longitude']}&n=11',
      );
      items.add(IssPassTimes.fromJson(json.decode(response.body)));
    } on PlatformException {
      currentLocation = null;
      items.add(null);
    }

    // Get items by http call & parse them
    response = await http.get(Url.issAstronauts);
    items.add(IssAstronauts.fromJson(json.decode(response.body)));

    setLoading(false);
  }

  IssLocation get issLocation => getItem(0);

  IssPassTimes get issPassTimes => getItem(1);

  IssAstronauts get issAstronauts => getItem(2);

  // TODO all this should come from Firebase
  String launchedTitle(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.launched.title',
        {'year': '1998'},
      );

  String launchedBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.launched.body',
        {'date': '20 November 1998', 'years': 20.toString()},
      );

  String altitudeBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.altitude.body',
        {'height': '400', 'velocity': '7.66'},
      );

  String orbitBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.orbit.body',
        {'period': '93', 'orbits': '16'},
      );

  String projectTitle(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.project.body',
        {'countries': '16', 'cost': '\$100,000,000'},
      );

  String numbersBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.numbers.body',
        {'days': '6000', 'orbits': '100.000'},
      );

  String specificationsBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.specifications.body',
        {'lenght': '73', 'width': '110', 'mass': '420,000'},
      );

  String get getCurrentLocation =>
      '${currentLocation['latitude']},  ${currentLocation['longitude']}';
}
