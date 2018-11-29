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
    response = await http.get('${Url.issPassTimes}?lat=___&long=___');
    items.add(IssPassTimes.fromJson(json.decode(response.body)));

    response = await http.get(Url.issAstronauts);
    items.add(IssAstronauts.fromJson(json.decode(response.body)));

    loadingState(false);
  }

  IssLocation get issLocation => getItem(0);

  IssPassTimes get issPassTimes => getItem(1);

  IssAstronauts get astronauts => getItem(2);

  String homeTitle(context) => FlutterI18n.translate(context, 'iss.home.title');

  String passTimesTitle(context) => FlutterI18n.translate(context, 'iss.times.title');

  String astronautsTitle(context) => FlutterI18n.translate(context, 'iss.astronauts.title');
}
