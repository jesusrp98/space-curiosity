import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../models/rockets/ship_info.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/row_item.dart';

/// SHIP PAGE CLASS
/// This class represent a ship page. It displays Ship's specs.
class ShipPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ShipInfo _ship;

  ShipPage(this._ship);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            floating: false,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.public),
                onPressed: () async => await FlutterWebBrowser.openWebPage(
                    url: _ship.url, androidToolbarColor: primaryColor),
                tooltip: 'MarineTraffic page',
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(_ship.name),
              background: InkWell(
                onTap: () => FlutterWebBrowser.openWebPage(
                      url: _ship.getProfilePhoto,
                      androidToolbarColor: primaryColor,
                    ),
                child: Hero(
                  tag: _ship.id,
                  child: CachedNetworkImage(
                    imageUrl: _ship.getProfilePhoto,
                    errorWidget: const Icon(Icons.error),
                    fadeInDuration: Duration(milliseconds: 100),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                _shipCard(),
                const SizedBox(height: 8.0),
                _specsCard(),
                (_ship.isLandable)
                    ? Column(
                        children: <Widget>[
                          const SizedBox(height: 8.0),
                          _landingsCard(),
                        ],
                      )
                    : const SizedBox(height: 0.0),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shipCard() {
    return CardPage(
      title: 'DESCRIPTION',
      body: Column(
        children: <Widget>[
          RowItem.textRow('Home port', _ship.homePort),
          const SizedBox(height: 12.0),
          RowItem.textRow('Built date', _ship.getBuiltFullDate),
          const Divider(height: 24.0),
          Text(
            _ship.description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15.0, color: secondaryText),
          )
        ],
      ),
    );
  }

  Widget _specsCard() {
    return CardPage(
      title: 'SPECIFICATIONS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Feature', _ship.use),
          const SizedBox(height: 12.0),
          RowItem.textRow('Ship model', _ship.getModel),
          const Divider(height: 24.0),
          RowItem.textRow('Primary role', _ship.primaryRole),
          (_ship.hasSeveralRoles)
              ? Column(
                  children: <Widget>[
                    const SizedBox(height: 12.0),
                    RowItem.textRow('Secondary role', _ship.secondaryRole),
                    const SizedBox(height: 12.0),
                  ],
                )
              : const SizedBox(height: 12.0),
          RowItem.textRow('Status', _ship.getStatus),
          const SizedBox(height: 12.0),
          RowItem.textRow('Coordinates', _ship.getCoordinates),
          const Divider(height: 24.0),
          RowItem.textRow('Total mass', _ship.getMass),
          const SizedBox(height: 12.0),
          RowItem.textRow('Current speed', _ship.getSpeed),
        ],
      ),
    );
  }

  Widget _landingsCard() {
    return CardPage(
      title: 'LANDINGS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Attempted landings', _ship.getAttemptedLandings),
          const SizedBox(height: 12.0),
          RowItem.textRow('Successful landings', _ship.getSuccessfulLandings),
        ],
      ),
    );
  }
}
