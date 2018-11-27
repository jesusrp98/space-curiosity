class IssLocation {
  final List<num> coordinates;
  final DateTime date;

  IssLocation({this.coordinates, this.date});

  factory IssLocation.fromJson(Map<String, dynamic> json) {
    return IssLocation(
      coordinates: [
        json['iss_position']['latitude'],
        json['iss_position']['longitude'],
      ],
      date: DateTime.fromMicrosecondsSinceEpoch(json['timestamp']),
    );
  }
}
