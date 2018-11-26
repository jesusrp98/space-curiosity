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
      date: DateTime.fromMicrosecondsSinceEpoch(json['risetime']),
    );
  }
}
