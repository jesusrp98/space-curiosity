import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/iss/pass_time.dart';
import '../../general/list_cell.dart';
import '../../general/separator.dart';

/// PASS TIMES TAB
/// This view holds a list with next ISS pass times & durations.
class PassTimesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PassTimesModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    FlutterI18n.translate(context, 'iss.times.title'),
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
                                    double.parse(
                                      model.issLocation['latitude'],
                                    ),
                                    double.parse(
                                      model.issLocation['longitude'],
                                    ),
                                  ),
                                  builder: (_) => const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 45.0,
                                      ),
                                ),
                                // Empty marker if we don't know location
                                model.userLocation != null
                                    ? Marker(
                                        width: 24.0,
                                        height: 24.0,
                                        point: LatLng(
                                          model.userLocation.latitude,
                                          model.userLocation.longitude,
                                        ),
                                        builder: (_) => const Icon(
                                              Icons.my_location,
                                              color: Colors.grey,
                                              size: 24.0,
                                            ),
                                      )
                                    : Marker(
                                        point: LatLng(0, 0),
                                        builder: (_) => Separator.none(),
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
                  : model.userLocation != null
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            _buildItem,
                            childCount: model.getItemCount,
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
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                              Separator.spacer(height: 16.0),
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
            ]),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ScopedModelDescendant<PassTimesModel>(
      builder: (context, child, model) {
        final PassTime passTime = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: const Icon(Icons.timer, size: 42.0),
            title: passTime.getDate(context),
            subtitle: passTime.getDuration(context),
            trailing: IconButton(
              icon: Icon(
                Icons.add,
                size: 25.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.add_event',
              ),
              onPressed: () => Add2Calendar.addEvent2Cal(Event(
                    title: FlutterI18n.translate(
                      context,
                      'iss.times.tab.event',
                    ),
                    description: passTime.getDuration(context),
                    location: model.getUserLocation,
                    startDate: passTime.date,
                    endDate: passTime.date.add(passTime.duration),
                  )),
            ),
          ),
          Separator.divider(height: 0.0, indent: 74.0)
        ]);
      },
    );
  }
}
