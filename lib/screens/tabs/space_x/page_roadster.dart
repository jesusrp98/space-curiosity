import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../../models/rockets/roadster.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/row_item.dart';

/// ROADSTER PAGE CLASS
/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Roadster _roadster;

  RoadsterPage(this._roadster);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) => SliverFab(
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.vehicle.roadster.watch_replay',
                ),
                onPressed: () => FlutterWebBrowser.openWebPage(
                      url: _roadster.video,
                      androidToolbarColor: primaryColor,
                    ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.public),
                      onPressed: () => FlutterWebBrowser.openWebPage(
                            url: _roadster.url,
                            androidToolbarColor: primaryColor,
                          ),
                      tooltip: FlutterI18n.translate(
                        context,
                        'spacex.vehicle.menu.wikipedia',
                      ),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(_roadster.name),
                    background: Swiper(
                      itemCount: _roadster.getPhotosCount,
                      itemBuilder: _buildImage,
                      autoplay: true,
                      autoplayDelay: 6000,
                      duration: 750,
                      onTap: (index) => FlutterWebBrowser.openWebPage(
                            url: _roadster.getPhoto(index),
                            androidToolbarColor: primaryColor,
                          ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      _roadsterCard(context),
                      const SizedBox(height: 8.0),
                      _vehicleCard(context),
                      const SizedBox(height: 8.0),
                      _orbitCard(context),
                      const SizedBox(height: 8.0),
                      Text(
                        FlutterI18n.translate(
                          context,
                          'spacex.vehicle.roadster.data_updated',
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: secondaryText),
                      )
                    ]),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _roadsterCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.description.title',
      ),
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.description.launch_date',
            ),
            _roadster.getFullFirstFlight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.description.launch_vehicle',
            ),
            'Falcon Heavy',
          ),
          const Divider(height: 24.0),
          Text(
            _roadster.description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15.0, color: secondaryText),
          )
        ],
      ),
    );
  }

  Widget _vehicleCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.vehicle.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.vehicle.mass',
            ),
            _roadster.getMass,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.vehicle.height',
            ),
            _roadster.getHeight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.vehicle.diameter',
            ),
            _roadster.getDiameter,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.vehicle.speed',
            ),
            _roadster.getSpeed,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.vehicle.distance_earth',
            ),
            _roadster.getEarthDistance,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.vehicle.distance_mars',
            ),
            _roadster.getMarsDistance,
          ),
        ],
      ),
    );
  }

  Widget _orbitCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.orbit.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.orbit.type',
            ),
            _roadster.getOrbit,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.orbit.period',
            ),
            _roadster.getPeriod,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.orbit.inclination',
            ),
            _roadster.getInclination,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.orbit.longitude',
            ),
            _roadster.getLongitude,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.orbit.apoapsis',
            ),
            _roadster.getApoapsis,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.roadster.orbit.periapsis',
            ),
            _roadster.getPeriapsis,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    CachedNetworkImage photo = CachedNetworkImage(
      imageUrl: _roadster.getPhoto(index),
      errorWidget: const Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 100),
      fit: BoxFit.cover,
    );
    if (index == 0)
      return Hero(tag: _roadster.id, child: photo);
    else
      return photo;
  }
}
