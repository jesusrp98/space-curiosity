import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/calculator/calculator.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _calcBloc = Provider.of<CalculatorModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.swap_horiz),
            label: _calcBloc.showKG ? Text("lbs") : Text("kg"),
            onPressed: () {
              _calcBloc.changeKG(!_calcBloc.showKG);
            },
          )
        ],
      ),
      body: Consumer<CalculatorModel>(builder: (context, model, child) {
        final state = model.calculator;
        return Stack(
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              top: 20.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                child: FlareActor(
                  "assets/animations/planets.flr",
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain,
                  animation: state.planet,
                  callback: (string) {
                    debugPrint(string);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 150.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove, size: 40.0),
                          onPressed: () {
                            _calcBloc.changeWeight(state.weight - 5);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            _calcBloc.currentWeight,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 40.0),
                          onPressed: () {
                            _calcBloc.changeWeight(state.weight + 5);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _calcBloc.planets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final p = _calcBloc.planets[index];
                        return InkWell(
                          onTap: () {
                            _calcBloc.changePlanet(p);
                          },
                          child: SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: FlareActor(
                                    "assets/animations/planets.flr",
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.contain,
                                    animation: p,
                                    callback: (string) {
                                      debugPrint(string);
                                    },
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(p)),
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
                bottom: 75.0,
                left: 10.0,
                right: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _calcBloc.planetWeight,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text("Your Weight on ${state.planet}"),
                      ],
                    ),
                  ],
                )),
          ],
        );
      }),
    );
  }
}
