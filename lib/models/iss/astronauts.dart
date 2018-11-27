class IssAstronauts {
  final List<Astronaut> astronauts;
  IssAstronauts(this.astronauts);
  factory IssAstronauts.fromJson(Map<String, dynamic> json) {
    return IssAstronauts(
      (json['people'] as List)
          .map((astronaut) => Astronaut.fromJson(astronaut))
          .toList(),
    );
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
}
