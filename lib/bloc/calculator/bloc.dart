import 'package:bloc/bloc.dart';
import 'package:space_news/bloc/bloc.dart';
import 'package:space_news/bloc/calculator/event.dart';
import 'package:space_news/models/calculator/weight.dart';

class CalculatorBloc extends Bloc<CalcEvent, Calculator> {
  @override
  Calculator get initialState => Calculator(
        weight: 150.0,
        planet: "Earth",
        surfaceGravity: 1.0,
      );

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

  @override
  Stream<Calculator> mapEventToState(
      Calculator currentState, CalcEvent event) async* {
    if (event is ChangePlanet) {
      var _state = Calculator(
        planet: event.planet,
        weight: currentState.weight,
        surfaceGravity: getSurfaceGravity(event.planet),
      );
      yield _state;
    } else if (event is ChangeWeight) {
      var _state = Calculator(
        planet: currentState.planet,
        weight: event.weight,
        surfaceGravity: currentState.surfaceGravity,
      );
      yield _state;
    }
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
}
