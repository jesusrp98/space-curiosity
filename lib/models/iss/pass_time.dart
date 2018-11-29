import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

class IssPassTimes {
  final List<PassTime> passTimes;

  IssPassTimes(this.passTimes);

  factory IssPassTimes.fromJson(Map<String, dynamic> json) {
    return IssPassTimes(
      (json['response'] as List)
          .map((passTime) => PassTime.fromJson(passTime))
          .toList(),
    );
  }
}

class PassTime {
  final Duration duration;
  final DateTime date;

  PassTime({this.duration, this.date});

  factory PassTime.fromJson(Map<String, dynamic> json) {
    return PassTime(
      duration: Duration(seconds: json['duration']),
      date: DateTime.fromMillisecondsSinceEpoch(json['risetime']).toLocal(),
    );
  }

  String get getDate =>
      DateFormat.yMMMMd().addPattern('Hm', '  ·  ').format(date);

  String getDuration(context) => FlutterI18n.translate(
        context,
        'iss.times.tab.duration',
        {'time': duration.inSeconds.toString()},
      );
}
