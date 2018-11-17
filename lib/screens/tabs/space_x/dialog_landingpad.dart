import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:latlong/latlong.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/landingpad.dart';
import '../../../util/colors.dart';
import '../../../widgets/row_item.dart';

class LandingpadDialog extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LandingpadModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.public),
                    onPressed: () => FlutterWebBrowser.openWebPage(
                          url: model.landingpad.url,
                          androidToolbarColor: primaryColor,
                        ),
                    tooltip: FlutterI18n.translate(
                      context,
                      'spacex.other.menu.wikipedia',
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(model.id),
                  background: (model.isLoading)
                      ? NativeLoadingIndicator(center: true)
                      : FlutterMap(
                          options: MapOptions(
                            center: LatLng(
                              model.landingpad.coordinates[0],
                              model.landingpad.coordinates[1],
                            ),
                            zoom: 6.0,
                            minZoom: 5.0,
                            maxZoom: 10.0,
                          ),
                          layers: <LayerOptions>[
                            TileLayerOptions(
                              urlTemplate:
                                  'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c', 'd'],
                              backgroundColor: primaryColor,
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                width: 45.0,
                                height: 45.0,
                                point: LatLng(
                                  model.landingpad.coordinates[0],
                                  model.landingpad.coordinates[1],
                                ),
                                builder: (_) => Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 45.0,
                                    ),
                              )
                            ])
                          ],
                        ),
                ),
              ),
              (model.isLoading)
                  ? SliverFillRemaining(
                      child: NativeLoadingIndicator(center: true),
                    )
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<LandingpadModel>(
      builder: (context, child, model) => Scrollbar(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        model.landingpad.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.status',
                        ),
                        model.landingpad.getStatus,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.location',
                        ),
                        model.landingpad.location,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.state',
                        ),
                        model.landingpad.state,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.coordinates',
                        ),
                        model.landingpad.getCoordinates,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.landing_type',
                        ),
                        model.landingpad.type,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.landings_successful',
                        ),
                        model.landingpad.getSuccessfulLandings,
                      ),
                      const Divider(height: 24.0),
                      Text(
                        model.landingpad.details,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: secondaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
