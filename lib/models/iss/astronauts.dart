class Astronauts {
  final List<Astronaut> astronauts;

  Astronauts(this.astronauts);

  factory Astronauts.fromJson(Map<String, dynamic> json) {
    return Astronauts(
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
