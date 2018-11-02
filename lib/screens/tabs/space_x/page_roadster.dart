import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                tooltip: 'Watch replay',
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
                      tooltip: 'Wikipedia article',
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
                            url: _roadster.getPhotoUrl(index),
                            androidToolbarColor: primaryColor,
                          ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      _roadsterCard(),
                      const SizedBox(height: 8.0),
                      _vehicleCard(),
                      const SizedBox(height: 8.0),
                      _orbitCard(),
                      const SizedBox(height: 8.0),
                      Text(
                        'Data is updated every 5 minutes',
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              color: secondaryText,
                            ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _roadsterCard() {
    return CardPage(
      title: 'DESCRIPTION',
      body: Column(
        children: <Widget>[
          RowItem.textRow('Launch date', _roadster.getFullFirstFlight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Launch vehicle', 'Falcon Heavy'),
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

  Widget _vehicleCard() {
    return CardPage(
      title: 'VEHICLE',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Total mass', _roadster.getMass),
          const SizedBox(height: 12.0),
          RowItem.textRow('Height', _roadster.getHeight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Diameter', _roadster.getDiameter),
          const SizedBox(height: 12.0),
          RowItem.textRow('Speed', _roadster.getSpeed),
          const Divider(height: 24.0),
          RowItem.textRow('Earth distance', _roadster.getEarthDistance),
          const SizedBox(height: 12.0),
          RowItem.textRow('Mars distance', _roadster.getMarsDistance),
        ],
      ),
    );
  }

  Widget _orbitCard() {
    return CardPage(
      title: 'ORBIT',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Orbit type', _roadster.getOrbit),
          const SizedBox(height: 12.0),
          RowItem.textRow('Period', _roadster.getPeriod),
          const Divider(height: 24.0),
          RowItem.textRow('Inclination', _roadster.getInclination),
          const SizedBox(height: 12.0),
          RowItem.textRow('Longitude', _roadster.getLongitude),
          const Divider(height: 24.0),
          RowItem.textRow('Apoapsis', _roadster.getApoapsis),
          const SizedBox(height: 12.0),
          RowItem.textRow('Periapsis', _roadster.getPeriapsis),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    CachedNetworkImage photo = CachedNetworkImage(
      imageUrl: _roadster.getPhotoUrl(index),
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
