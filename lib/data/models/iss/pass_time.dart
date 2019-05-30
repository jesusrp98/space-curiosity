import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../../util/url.dart';
import '../models.dart';

/// ISS PASS TIME MODEL
/// When & by how long ISS will pass in your geographic location.
class PassTimesModel extends QueryModel {
  Map<String, String> _issLocation;
  LocationData _userLocation;

  @override
  Future loadData([BuildContext context]) async {
    // Get item by http call
    var response = await http.get(Url.issLocation);

    // Clear old data
    clearItems();

    _issLocation = Map.from(json.decode(response.body)['iss_position']);

    // Ask user about location
    // Parse if permission are granted
    try {
      // Get user's location
      print("Getting Location...");
      _userLocation = await Location().getLocation();
      print("Location: ${_userLocation.toString()}");
      // Get items by http call & parse them
      response = await http.get(
        '${Url.issPassTimes}?lat=${_userLocation.latitude}&lon=${_userLocation.longitude}&n=10',
      );
      var snapshot = json.decode(response.body)['response'];
      items.addAll(
        snapshot.map((passTime) => PassTime.fromJson(passTime)).toList(),
      );
    } on PlatformException {
      _userLocation = null;
      print("Error getting location");
    }

    // Finished loading data
    setLoading(false);
  }

  Map<String, String> get issLocation => _issLocation;

  LocationData get userLocation => _userLocation;

  String get getUserLocation =>
      '${userLocation.latitude.toStringAsPrecision(5)},  ${userLocation.longitude.toStringAsPrecision(5)}';
}

class PassTime {
  final Duration duration;
  final DateTime date;

  PassTime({this.duration, this.date});

  factory PassTime.fromJson(Map<String, dynamic> json) {
    return PassTime(
      duration: Duration(seconds: json['duration']),
      date: DateTime.fromMillisecondsSinceEpoch(json['risetime'] * 1000)
          .toLocal(),
    );
  }

  String getDate(context) => FlutterI18n.translate(
        context,
        'spacex.other.date.time',
        {'date': DateFormat.yMMMMd().format(date), 'hour': getTime},
      );

  String get getTime => '${DateFormat.Hm().format(date)} ${date.timeZoneName}';

  String getDuration(context) => FlutterI18n.translate(
        context,
        'iss.times.tab.duration',
        {'time': NumberFormat.decimalPattern().format(duration.inSeconds)},
      );
}
