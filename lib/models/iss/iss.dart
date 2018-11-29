import 'dart:convert';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';
import 'astronauts.dart';
import 'current_location.dart';
import 'pass_time.dart';

class IssModel extends QuerryModel {
  @override
  Future loadData() async {
    response = await http.get(Url.issLocation);
    items.add(IssLocation.fromJson(json.decode(response.body)));

    // TODO get location
    response =
        await http.get('${Url.issPassTimes}?lat=48.864716&lon=2.349014&n=11');
    items.add(IssPassTimes.fromJson(json.decode(response.body)));

    response = await http.get(Url.issAstronauts);
    items.add(IssAstronauts.fromJson(json.decode(response.body)));

    loadingState(false);
  }

  IssLocation get issLocation => getItem(0);

  IssPassTimes get issPassTimes => getItem(1);

  IssAstronauts get issAstronauts => getItem(2);

  String homeTitle(context) => FlutterI18n.translate(context, 'iss.home.title');

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
        {'height': '20 November 1998', 'velocity': '7.66'},
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
        {'days': '20 November 1998', 'orbits': 20.toString()},
      );

  String specificationsBody(context) => FlutterI18n.translate(
        context,
        'iss.home.tab.specifications.body',
        {'lenght': '73', 'width': '110', 'mass': '420,000'},
      );

  String passTimesTitle(context) =>
      FlutterI18n.translate(context, 'iss.times.title');

  String astronautsTitle(context) =>
      FlutterI18n.translate(context, 'iss.astronauts.title');
}
