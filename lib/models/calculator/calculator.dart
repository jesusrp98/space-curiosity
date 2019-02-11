import 'package:equatable/equatable.dart';

class Calculator extends Equatable {
  final String id;
  num weight;

  Calculator({
    this.weight,
    this.id,
  }) : super([id, weight]);

  @override
  String toString() => 'Calculator { id: $id }';
}
