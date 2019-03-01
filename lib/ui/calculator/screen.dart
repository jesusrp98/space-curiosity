import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../bloc/bloc.dart';
import '../../bloc/calculator/bloc.dart';
import '../../models/calculator/planet.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorBloc _bloc = CalculatorBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalculatorBloc>(bloc: _bloc, child: _Content());
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class _Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool _showKg = false;

  @override
  Widget build(BuildContext context) {
    final CalculatorBloc _calcBloc = BlocProvider.of<CalculatorBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, 'weight.title'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, 
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.swap_horiz),
            label: Text(FlutterI18n.translate(
              context,
              _showKg ? 'weight.units.kg' : 'weight.units.kg',
            )),
            onPressed: () => setState(() => _showKg = !_showKg),
          )
        ],
      ),
      body: BlocBuilder(
        bloc: _calcBloc,
        builder: (context, Planet planet) => Stack(children: <Widget>[
              Positioned(
                bottom: 0,
                top: 20,
                left: 0,
                right: 0,
                child: Container(
                  child: FlareActor(
                    'assets/animations/planets.flr',
                    alignment: Alignment.topCenter,
                    fit: BoxFit.contain,
                    animation: planet.name,
                    callback: (string) => debugPrint(string),
                  ),
                ),
              ),
              Positioned(
                bottom: 150,
                left: 10,
                right: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.remove, size: 40),
                            onPressed: planet.weight <= 0
                                ? null
                                : () => _calcBloc.dispatch(
                                      ChangeWeight(planet.weight - 5),
                                    ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              _currentWeight(planet),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 40),
                            onPressed: () => _calcBloc.dispatch(
                                  ChangeWeight(planet.weight + 5),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _calcBloc.planets.length,
                        itemBuilder: (context, index) {
                          final p = _calcBloc.planets[index];
                          return InkWell(
                            onTap: () => _calcBloc.dispatch(ChangePlanet(p)),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: FlareActor(
                                      'assets/animations/planets.flr',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                      animation: p,
                                      callback: (string) => debugPrint(string),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    child: Text(p),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 75,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            _planetWeight(_calcBloc),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.display1,
                          ),
                          Text(FlutterI18n.translate(
                            context,
                            'weight.your_weight',
                            {'planet': planet.name},
                          )),
                        ],
                      ),
                    ],
                  )),
            ]),
      ),
    );
  }

  String _currentWeight(Planet planet) {
    return _showKg
        ? '${(planet.weight / 2.204623).round().toString()} ${FlutterI18n.translate(context, 'weight.units.kg')}'
        : '${planet.weight.round().toString()} ${FlutterI18n.translate(context, 'weight.units.lb')}';
  }

  String _planetWeight(CalculatorBloc bloc) {
    if (_showKg) return bloc.currentState.weightKg;
    return bloc.currentState.weightLb;
  }
}
