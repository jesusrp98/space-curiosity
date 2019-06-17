import 'package:flutter/material.dart';

import '../../classes/calculator/weight.dart';

class CalculatorModel extends ChangeNotifier {
  Calculator _calculator = Calculator(
    weight: 150.0,
    planet: "Earth",
    surfaceGravity: 1.0,
  );

  bool _showKG = false;

  void init() {}

  bool get showKG => _showKG;

  void changeKG(bool value) {
    _showKG = value;
    notifyListeners();
  }

  Calculator get calculator => _calculator;

  List<String> get planets => const [
        "Earth",
        "Mercury",
        "Venus",
        "Mars",
        "Jupiter",
        "Saturn",
        "Uranus",
        "Neptune"
      ];

  void changePlanet(String value) {
    _calculator = Calculator(
      planet: value,
      weight: _calculator.weight,
      surfaceGravity: getSurfaceGravity(value),
    );
    notifyListeners();
  }

  void changeWeight(num value) {
    _calculator = Calculator(
      planet: _calculator.planet,
      weight: value,
      surfaceGravity: _calculator.surfaceGravity,
    );
    notifyListeners();
  }

  num getSurfaceGravity(String planet) {
    if (planet == "Mercury") return 0.38;
    if (planet == "Venus") return 0.91;
    if (planet == "Mars") return 0.38;
    if (planet == "Jupiter") return 2.34;
    if (planet == "Saturn") return 0.93;
    if (planet == "Uranus") return 0.92;
    if (planet == "Neptune") return 1.12;
    return 1.0;
  }

  String get currentWeight {
    if (_showKG)
      return (_calculator.weight / 2.2046).round().toString() + " kg";
    return _calculator.weight.round().toString() + " lbs";
  }

  String get planetWeight {
    if (_showKG) return _calculator.planetWeightFormatKg;
    return _calculator.planetWeightFormatLbs;
  }
}
