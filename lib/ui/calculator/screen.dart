import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_news/bloc/bloc.dart';
import 'package:space_news/models/calculator/weight.dart';

import '../../bloc/calculator/bloc.dart';
import '../general/string_picker_tile.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  CalculatorScreenState createState() {
    return new CalculatorScreenState();
  }
}

class CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorBloc _bloc = CalculatorBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalculatorBloc>(
      bloc: _bloc,
      child: new _Content(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalculatorBloc _calcBloc = BlocProvider.of<CalculatorBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder(
          bloc: _calcBloc,
          builder: (BuildContext context, Calculator state) {
            return ListView(
              children: <Widget>[
                StringPickerTile(
                  initialItem: state.planet,
                  items: _calcBloc.planets,
                  title: Text("Select Planet"),
                  subtitle: Text(state.planet),
                  onChanged: (int index) {
                    var _planet = _calcBloc.planets[index];
                    print("Planet => $_planet");
                    _calcBloc.dispatch(ChangePlanet(_planet));
                  },
                ),
                ListTile(
                  title: TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (String value) {
                      _calcBloc.dispatch(ChangeWeight(num.parse(value)));
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    _calcBloc.currentState.planetWeight.toStringAsFixed(3),
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
            );
          }),
    );
  }
}
