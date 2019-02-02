import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/iss/iss.dart';
import '../../../widgets/list_cell.dart';
import '../../../widgets/separator.dart';

class IssHomeTab extends StatelessWidget {
  Future<Null> _onRefresh(IssModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IssModel>(
      builder: (context, child, model) => Scaffold(
            body: RefreshIndicator(
              onRefresh: () => _onRefresh(model),
              child: CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      FlutterI18n.translate(context, 'iss.home.title'),
                    ),
                    background: model.isLoading
                        ? NativeLoadingIndicator(center: true)
                        : FlutterMap(
                            options: MapOptions(
                              center: LatLng(0.0, 0.0),
                              zoom: 1.0,
                              minZoom: 1.0,
                              maxZoom: 5.0,
                            ),
                            layers: <LayerOptions>[
                              TileLayerOptions(
                                urlTemplate:
                                    'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                                subdomains: ['a', 'b', 'c', 'd'],
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              MarkerLayerOptions(
                                markers: <Marker>[
                                  Marker(
                                    width: 45.0,
                                    height: 45.0,
                                    point: LatLng(
                                      model.issLocation.coordinates[0],
                                      model.issLocation.coordinates[1],
                                    ),
                                    builder: (_) => const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 45.0,
                                        ),
                                  )
                                ],
                              )
                            ],
                          ),
                  ),
                ),
                model.isLoading
                    ? SliverFillRemaining(
                        child: NativeLoadingIndicator(center: true),
                      )
                    : SliverToBoxAdapter(child: _buildBody())
              ]),
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<IssModel>(
      builder: (context, child, model) => Column(
            children: <Widget>[
              ListCell(
                leading: const Icon(Icons.flight_takeoff, size: 42.0),
                title: model.launchedTitle(context),
                subtitle: model.launchedBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.public, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.altitude.title',
                ),
                subtitle: model.altitudeBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.update, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.orbit.title',
                ),
                subtitle: model.orbitBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.attach_money, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.project.title',
                ),
                subtitle: model.projectTitle(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.people, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.numbers.title',
                ),
                subtitle: model.numbersBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.straighten, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.specifications.title',
                ),
                subtitle: model.specificationsBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
            ],
          ),
    );
  }
}
