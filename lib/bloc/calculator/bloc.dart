import 'package:bloc/bloc.dart';
import 'package:space_news/models/calculator/calculator.dart';

enum CalculatorEvent { increment, decrement }

class CalculatorBloc extends Bloc<CalculatorEvent, Calculator> {
  @override
  Calculator get initialState => Calculator();

  List<String> get planets => ["Earth", "Mars"];

  @override
  Stream<Calculator> mapEventToState(
      Calculator currentState, CalculatorEvent event) async* {
    switch (event) {
      case CalculatorEvent.decrement:
        yield currentState..weight -= 1;
        break;
      case CalculatorEvent.increment:
        yield currentState..weight += 1;
        break;
    }
  }
}
