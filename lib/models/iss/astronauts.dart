import 'dart:convert';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';

class AstronautsModel extends QuerryModel {
  @override
  Future loadData() async {
    // Get items by http call
    response = await http.get(Url.issAstronauts);
    snapshot = json.decode(response.body)['people'];

    // Clear old data
    clearItems();

    // Add parsed items
    items.addAll(
      snapshot.map((astronaut) => Astronaut.fromJson(astronaut)).toList(),
    );

    // Finished loading data
    setLoading(false);
  }
}

class Astronaut {
  final String name, craft;

  Astronaut({this.name, this.craft});

  factory Astronaut.fromJson(Map<String, dynamic> json) {
    return Astronaut(
      name: json['name'],
      craft: json['craft'],
    );
  }

  String description(context) => FlutterI18n.translate(
        context,
        'iss.astronauts.tab.from',
        {'place': craft},
      );
}
