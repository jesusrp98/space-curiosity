import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_news/scoped_model/general_model.dart';
import 'package:space_news/util/url.dart';
import 'package:space_news/models/rockets/launch.dart';

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
