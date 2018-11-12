import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:latlong/latlong.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/launchpad.dart';
import '../../../util/colors.dart';
import '../../../widgets/row_item.dart';

class LaunchpadDialog extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LaunchpadModel>(
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
                          url: model.launchpad.url,
                          androidToolbarColor: primaryColor,
                        ),
                    tooltip: FlutterI18n.translate(
                      context,
                      'spacex.dialog.menu.wikipedia',
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(model.name),
                  background: (model.isLoading)
                      ? NativeLoadingIndicator(center: true)
                      : FlutterMap(
                          options: MapOptions(
                            center: LatLng(
                              model.launchpad.coordinates[0],
                              model.launchpad.coordinates[1],
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
                                  model.launchpad.coordinates[0],
                                  model.launchpad.coordinates[1],
                                ),
                                builder: (_) => Icon(
                                      Icons.location_on,
                                      color: Colors.red[700],
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
    return ScopedModelDescendant<LaunchpadModel>(
      builder: (context, child, model) => Scrollbar(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        model.launchpad.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.status',
                        ),
                        model.launchpad.getStatus,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.location',
                        ),
                        model.launchpad.location,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.state',
                        ),
                        model.launchpad.state,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.coordinates',
                        ),
                        model.launchpad.getCoordinates,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.pad.launches_successful',
                        ),
                        model.launchpad.getSuccessfulLaunches,
                      ),
                      const Divider(height: 24.0),
                      Text(
                        model.launchpad.details,
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
