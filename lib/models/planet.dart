class Planet {
  final String imageUrl;
  final String name;
  final String description;
  final num aphelion;
  final num perihelion;
  final String orbit;
  final num period;
  final num speed;
  final num inclination;
  final num radius;
  final num volume;
  final num mass;
  final num density;
  final num gravity;
  final num escapeVelocity;
  final num temperature;
  final num pressure;
  //final Map<String, num> atmosphereComposition;

  Planet({
    this.imageUrl,
    this.name,
    this.description,
    this.aphelion,
    this.perihelion,
    this.orbit,
    this.period,
    this.speed,
    this.inclination,
    this.radius,
    this.volume,
    this.mass,
    this.density,
    this.gravity,
    this.escapeVelocity,
    this.temperature,
    this.pressure,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      aphelion: json['aphelion'],
      perihelion: json['perihelion'],
      orbit: json['orbit'],
      period: json['period'],
      speed: json['speed'],
      inclination: json['inclination'],
      radius: json['radius'],
      volume: json['volume'],
      mass: json['mass'],
      density: json['density'],
      gravity: json['gravity'],
      escapeVelocity: json['escapeVelocity'],
      temperature: json['temperature'],
      pressure: json['pressure'],
    );
  }
}
