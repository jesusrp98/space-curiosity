import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../data/models/planets/celestial_body.dart';
import '../../general/card_page.dart';
import '../../general/head_card_page.dart';
import '../../general/hero_image.dart';
import '../../general/row_item.dart';
import 'edit.dart';

class CelestialBodyPage extends StatelessWidget {
  final CelestialBody celestialBody;
  final BodyType type;

  CelestialBodyPage({this.celestialBody, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(celestialBody.name),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditPlanetPage(
                          null,
                          id: celestialBody.id,
                          type: BodyType.celestialBody,
                        ),
                    fullscreenDialog: true,
                  ),
                ).then(
                  (value) {
                    if (value != null) {
                      String _value = value;
                      if (_value.contains('deleted')) Navigator.pop(context);
                    }
                  },
                ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddEditPlanetPage(celestialBody, type: type),
                    fullscreenDialog: true,
                  ),
                ).then((value) {
                  if (value != null) {
                    String _value = value;
                    if (_value.contains('deleted')) Navigator.pop(context);
                  }
                }),
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                _headCard(context),
                const SizedBox(height: 8.0),
                _detailsCard(context),
              ]),
            )
          ]),
        ),
      ),
    );
  }

  Widget _headCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage.card(
        url: celestialBody.imageUrl,
        tag: celestialBody.id,
        onTap: () async => await FlutterWebBrowser.openWebPage(
              url: celestialBody.imageUrl,
              androidToolbarColor: Theme.of(context).primaryColor,
            ),
      ),
      title: celestialBody.name,
      subtitle1: Text(
        celestialBody.getPopulation,
        style: Theme.of(context).textTheme.subhead.copyWith(
              color: Theme.of(context).textTheme.caption.color,
            ),
      ),
      subtitle2: Text(
        "I'm a subtitle!",
        style: Theme.of(context).textTheme.subhead.copyWith(
              color: Theme.of(context).textTheme.caption.color,
            ),
      ),
      details: celestialBody.description,
    );
  }

  Widget _detailsCard(BuildContext context) {
    return CardPage(
      title: 'DETAILS',
      body: Column(
        children: <Widget>[
          RowItem.textRow(context, 'Aphelion', celestialBody.getAphelion),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Perihelion', celestialBody.getPerihelion),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Period', celestialBody.getPeriod),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Speed', celestialBody.getSpeed),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Obliquity', celestialBody.getObliquity),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Radius', celestialBody.getRadius),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Volume', celestialBody.getVolume),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Mass', celestialBody.getMass),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Density', celestialBody.getDensity),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Gravity', celestialBody.getGravity),
          const SizedBox(height: 8.0),
          RowItem.textRow(
            context,
            'Escape velocity',
            celestialBody.getEscapeVelocity,
          ),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Temperature', celestialBody.getTemperature),
          const SizedBox(height: 8.0),
          RowItem.textRow(context, 'Pressure', celestialBody.getPressure),
        ],
      ),
    );
  }
}
