import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';
import 'current_location.dart';
import 'pass_time.dart';

class IssModel extends QuerryModel {
  @override
  Future loadData() async {
    response = await http.get(Url.issLocation);
    items.add(IssLocation.fromJson(json.decode(response.body)));

    response = await http.get('${Url.issPassTimes}?lat=___&long=___');
    items.add(IssPassTimes.fromJson(json.decode(response.body)));

    loadingState(false);
  }
}
