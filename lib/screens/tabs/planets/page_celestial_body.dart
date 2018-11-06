import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../models/planets/celestial_body.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/head_card_page.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/row_item.dart';
import 'add_edit_planet.dart';

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
        size: HeroImage.bigSize,
        onTap: () => FlutterWebBrowser.openWebPage(
              url: celestialBody.imageUrl,
              androidToolbarColor: primaryColor,
            ),
      ),
      title: celestialBody.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            celestialBody.getPopulation,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            "I'm a subtitle!",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
        ],
      ),
      details: celestialBody.description,
    );
  }

  Widget _detailsCard(BuildContext context) {
    return CardPage(
      title: 'DETAILS',
      body: Column(
        children: <Widget>[
          RowItem.textRow('Aphelion', celestialBody.getAphelion),
          const SizedBox(height: 8.0),
          RowItem.textRow('Perihelion', celestialBody.getPerihelion),
          const SizedBox(height: 8.0),
          RowItem.textRow('Period', celestialBody.getPeriod),
          const SizedBox(height: 8.0),
          RowItem.textRow('Speed', celestialBody.getSpeed),
          const SizedBox(height: 8.0),
          RowItem.textRow('Obliquity', celestialBody.getObliquity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Radius', celestialBody.getRadius),
          const SizedBox(height: 8.0),
          RowItem.textRow('Volume', celestialBody.getVolume),
          const SizedBox(height: 8.0),
          RowItem.textRow('Mass', celestialBody.getMass),
          const SizedBox(height: 8.0),
          RowItem.textRow('Density', celestialBody.getDensity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Gravity', celestialBody.getGravity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Escape velocity', celestialBody.getEscapeVelocity),
          const SizedBox(height: 8.0),
          RowItem.textRow('Temperature', celestialBody.getTemperature),
          const SizedBox(height: 8.0),
          RowItem.textRow('Pressure', celestialBody.getPressure),
        ],
      ),
    );
  }
}
