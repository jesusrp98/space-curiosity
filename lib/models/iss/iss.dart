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
    // Get it by http call & parse it
    response = await http.get(Url.issLocation);
print(1);
    // Clear old data
    clearItems();

    items.add(IssLocation.fromJson(json.decode(response.body)));

    // Ask user about location
    // Parse if permission are granted
    try {
print(2.1);      
      // Get user's location
      currentLocation = await Location().getLocation();
print(2.2);
      // Get items by http call & parse them
      response = await http.get(
        '${Url.issPassTimes}?lat=${currentLocation['latitude']}&lon=${currentLocation['longitude']}&n=11',
      );
print(2.3);
      items.add(IssPassTimes.fromJson(json.decode(response.body)));
print(2.4);      
    } on PlatformException {
      currentLocation = null;
print('error');      
      items.add(null);
    }

    // Get items by http call & parse them
    response = await http.get(Url.issAstronauts);
    items.add(IssAstronauts.fromJson(json.decode(response.body)));
print(3);
    // Finished loading data
    setLoading(false);
  }

  IssLocation get issLocation => getItem(0);

  IssPassTimes get issPassTimes => getItem(1);

  IssAstronauts get issAstronauts => getItem(2);

  String get getCurrentLocation =>
      '${currentLocation['latitude']},  ${currentLocation['longitude']}';
}
