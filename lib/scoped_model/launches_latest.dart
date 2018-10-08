import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/rockets/launch.dart';
import '../util/url.dart';
import 'general_model.dart';

class LaunchesLatestModel extends GeneralModel {
  @override
  Future loadData() async {
    final response = await http.get(Url.launchesList);

    list.clear();
    List jsonDecoded = json.decode(response.body);
    list.addAll(jsonDecoded.map((launch) => Launch.fromJson(launch)).toList());

    loadingState(false);
  }
}
