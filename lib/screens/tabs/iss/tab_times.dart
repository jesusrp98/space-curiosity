import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/iss/iss.dart';
import '../../../models/iss/pass_time.dart';
import '../../../util/colors.dart';
import '../../../widgets/list_cell.dart';

class IssTimesTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Null> _onRefresh(IssModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IssModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: RefreshIndicator(
              onRefresh: () => _onRefresh(model),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(model.passTimesTitle(context)),
                      background: (model.isLoading)
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
                                  backgroundColor: primaryColor,
                                ),
                                MarkerLayerOptions(
                                  markers: [
                                    Marker(
                                      width: 45.0,
                                      height: 45.0,
                                      point: LatLng(
                                        model.issLocation.coordinates[0],
                                        model.issLocation.coordinates[1],
                                      ),
                                      builder: (_) => Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 45.0,
                                          ),
                                    ),
                                    Marker(
                                      width: 24.0,
                                      height: 24.0,
                                      point: LatLng(
                                        model.currentLocation['latitude'],
                                        model.currentLocation['longitude'],
                                      ),
                                      builder: (_) => Icon(
                                            Icons.my_location,
                                            color: Colors.grey,
                                            size: 24.0,
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
                      : model.currentLocation != null
                          ? SliverList(
                              key:
                                  PageStorageKey(model.passTimesTitle(context)),
                              delegate: SliverChildBuilderDelegate(
                                _buildItem,
                                childCount: model.issPassTimes.passTimes.length,
                              ),
                            )
                          : SliverFillRemaining(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.sentiment_dissatisfied,
                                    size: 100.0,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color,
                                  ),
                                  Container(height: 16.0),
                                  Text(
                                    FlutterI18n.translate(
                                      context,
                                      'iss.times.tab.location_error',
                                    ),
                                    style: Theme.of(context).textTheme.title,
                                  )
                                ],
                              ),
                            )
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ScopedModelDescendant<IssModel>(
      builder: (context, child, model) {
        final PassTime passTime = model.issPassTimes.passTimes[index];

        return Column(
          children: <Widget>[
            ListCell(
              leading: Icon(Icons.timer, size: 42.0),
              title: passTime.getDate,
              subtitle: passTime.getDuration(context),
              trailing: IconButton(
                icon: Icon(
                  Icons.event,
                  size: 27.0,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.other.tooltip.add_event',
                ),
                onPressed: () => Add2Calendar.addEvent2Cal(
                      Event(
                        title: FlutterI18n.translate(
                          context,
                          'iss.times.tab.event',
                        ),
                        startDate: passTime.date,
                        endDate: passTime.date.add(passTime.duration),
                      ),
                    ),
              ),
            ),
            const Divider(height: 0.0, indent: 74.0)
          ],
        );
      },
    );
  }
}
