import 'dart:convert';

import 'package:duration/duration.dart';
import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';
import 'launch.dart';

class SpacexHomeModel extends QuerryModel {
  Launch launch;

  @override
  Future loadData() async {
    final response = await http.get(Url.nextLaunch);
    clearLists();

    photos.addAll(Url.spacexHomeScreen);
    launch = Launch.fromJson(json.decode(response.body));

    loadingState(false);
  }

  String get getCountdown =>
      'T - ${printDuration(launch.launchDate.difference(DateTime.now()), abbreviated: true, delimiter: ' : ', spacer: '')}';
}
