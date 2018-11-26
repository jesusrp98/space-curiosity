class IssLocation {
  final List<num> location;
  final DateTime date;

  IssLocation({this.location, this.date});

  factory IssLocation.fromJson(Map<String, dynamic> json) {
    return IssLocation(
      location: [
        json['iss_position']['latitude'],
        json['iss_position']['longitude'],
      ],
      date: DateTime.fromMicrosecondsSinceEpoch(json['timestamp']),
    );
  }
}
