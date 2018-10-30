import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_news/models/rockets/launch.dart';

import '../../util/url.dart';
import '../querry_model.dart';

class SpacexHomeModel extends QuerryModel {
  Launch launch;

  @override
  Future loadData() async {
    final response = await http.get(Url.nextLaunch);
    launch = Launch.fromJson(json.decode(response.body));

    loadingState(false);
  }

  String get getCountdown =>
      'T - ${launch.launchDate.difference(DateTime.now()).toString()}';
}
