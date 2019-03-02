import 'package:equatable/equatable.dart';

abstract class CalcEvent extends Equatable {}

class ChangePlanet extends CalcEvent {
  final String planet;

  ChangePlanet(this.planet);

  @override
  String toString() => 'Change Planet => $planet';
}

class ChangeWeight extends CalcEvent {
  final num weight;

  ChangeWeight(this.weight);

  @override
  String toString() => 'Change Weight => $weight';
}


