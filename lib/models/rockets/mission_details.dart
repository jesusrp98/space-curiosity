/// DETAILS MISSION MODEL
/// Auxiliary model to storage a mission's mane with its id number.
class DetailsMission {
  final String name;
  final int id;

  DetailsMission(this.name, this.id);

  factory DetailsMission.fromJson(Map<String, dynamic> json) {
    return DetailsMission(json['name'], json['flight']);
  }
}
