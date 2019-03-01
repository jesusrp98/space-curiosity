class Planet {
  final String name;
  final num weight, surfaceGravity;

  Planet({
    this.name,
    this.weight,
    this.surfaceGravity,
  });

  num get planetWeight => weight * surfaceGravity;

  String get weightLb => planetWeight.round().toString() + " lbs";
  String get weightKg =>
      (planetWeight / 2.204623).round().toString() + " kg";
}
