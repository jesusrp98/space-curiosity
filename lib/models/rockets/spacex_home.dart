import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';

class SpacexHomeModel extends QuerryModel {
  @override
  Future loadData() async {
    // final companyResponse = await http.get(Url.companyDetails);
    // response = await http.get(Url.companyHistory);
    clearLists();

    // List jsonDecoded = json.decode(response.body);
    // list.addAll(jsonDecoded
    //     .map((achievement) => Achievement.fromJson(achievement))
    //     .toList());

    // _company = Company.fromJson(json.decode(companyResponse.body));

    images.addAll(Url.spacexHomeScreen);

    loadingState(false);
  }
}