import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../general/string_picker_tile.dart';

class CalculatorScreen extends StatelessWidget {
  final CalculatorBloc calculatorBloc;

  CalculatorScreen({this.calculatorBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: calculatorBloc,
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: <Widget>[
            StringPickerTile(
              items: calculatorBloc.planets,
              title: Text("Select Planet"),
            ),
          ],
        ),
      ),
    );
  }
}
