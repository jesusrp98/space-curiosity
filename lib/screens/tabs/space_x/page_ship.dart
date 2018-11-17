import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
                onPressed: () => FlutterWebBrowser.openWebPage(
                    url: _ship.url, androidToolbarColor: primaryColor),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.other.menu.marine_traffic',
                ),
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
                _shipCard(context),
                const SizedBox(height: 8.0),
                _specsCard(context),
                const SizedBox(height: 8.0),
                _missionsCard(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shipCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.description.title',
      ),
      body: Column(
        children: <Widget>[
          RowItem.textRow(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.ship.description.home_port',
              ),
              _ship.homePort),
          const SizedBox(height: 12.0),
          RowItem.textRow(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.ship.description.built_date',
              ),
              _ship.getBuiltFullDate),
          _ship.isLandable
              ? Column(
                  children: <Widget>[
                    const Divider(height: 24.0),
                    RowItem.textRow(
                      FlutterI18n.translate(
                        context,
                        'spacex.vehicle.ship.landings.landings_successful',
                      ),
                      _ship.getSuccessfulLandings,
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  Widget _specsCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.specifications.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.feature',
            ),
            _ship.use,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.model',
            ),
            _ship.getModel(context),
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.role_primary',
            ),
            _ship.primaryRole,
          ),
          (_ship.hasSeveralRoles)
              ? Column(
                  children: <Widget>[
                    const SizedBox(height: 12.0),
                    RowItem.textRow(
                      FlutterI18n.translate(
                        context,
                        'spacex.vehicle.ship.specifications.role_secondary',
                      ),
                      _ship.secondaryRole,
                    ),
                    const SizedBox(height: 12.0),
                  ],
                )
              : const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.status',
            ),
            _ship.getStatus(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.coordinates',
            ),
            _ship.getCoordinates(context),
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.mass',
            ),
            _ship.getMass(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.speed',
            ),
            _ship.getSpeed(context),
          ),
        ],
      ),
    );
  }

  Widget _missionsCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.missions.title',
      ),
      body: Column(
        children: _ship.missions
            .map(
              (mission) => _getMission(context, _ship.missions, mission),
            )
            .toList(),
      ),
    );
  }

  Column _getMission(BuildContext context, List missions, mission) {
    return Column(
      children: <Widget>[
        RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.missions.mission',
              {'number': mission.id.toString()},
            ),
            mission.name),
      ]..add(
          mission != missions.last ? const SizedBox(height: 12.0) : Container(),
        ),
    );
  }
}
