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
        "Neptune",
      ];

  String getPlanetImage(String value, {bool network = false}) {
    if (network) {
      if (value == "Earth")
        return "https://vignette.wikia.nocookie.net/thesolarsystem6361/images/7/74/Earth_spacepedia.png/revision/latest?cb=20180301164134";
      if (value == "Mercury")
        return "https://images-na.ssl-images-amazon.com/images/I/81JR1oDI76L.png";
      if (value == "Venus")
        return "https://www.solarsystemscope.com/spacepedia/images/handbook/renders/venus.png";
      if (value == "Mars")
        return "https://pngimg.com/uploads/mars_planet/mars_planet_PNG23.png";
      if (value == "Jupiter")
        return "https://images-na.ssl-images-amazon.com/images/I/81JR1oDI76L.png";
      if (value == "Saturn")
        return "https://images-na.ssl-images-amazon.com/images/I/81JR1oDI76L.png";
      if (value == "Uranus")
        return "https://images-na.ssl-images-amazon.com/images/I/81JR1oDI76L.png";
      if (value == "Neptune")
        return "https://images-na.ssl-images-amazon.com/images/I/81JR1oDI76L.png";
      return "";
    }
    if (value == "Earth") return "assets/images/earth.png";
    if (value == "Mercury") return "assets/images/mercury.png";
    if (value == "Venus") return "assets/images/earth.png";
    if (value == "Mars") return "assets/images/mars.png";
    if (value == "Jupiter") return "assets/images/earth.png";
    if (value == "Saturn") return "assets/images/earth.png";
    if (value == "Uranus") return "assets/images/earth.png";
    if (value == "Neptune") return "assets/images/neptune.png";
    if (value == "Moon") return "assets/images/moon.png";
    return "";
  }

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
