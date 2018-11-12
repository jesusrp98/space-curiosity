import 'package:intl/intl.dart';

/// VEHICLE DETAILS CLASS
/// Represents a general vehicle, such a capsule or a core, used in any mission.
abstract class VehicleDetails {
  final String serial, status, details;
  final DateTime firstLaunched;
  final List missions;

  VehicleDetails({
    this.serial,
    this.status,
    this.details,
    this.firstLaunched,
    this.missions,
  });

  String get getStatus => '${status[0].toUpperCase()}${status.substring(1)}';

  String getDetails(context);

  String get getFirstLaunched => DateFormat.yMMMMd().format(firstLaunched);

  String get getLaunches => missions.length.toString();

  bool get hasMissions => missions.isNotEmpty;
}

class DetailsMission {
  final String name;
  final int id;

  DetailsMission(this.name, this.id);

  factory DetailsMission.fromJson(Map<String, dynamic> json) =>
      DetailsMission(json['name'], json['flight']);
}
