import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/models/iss/pass_time.dart';
import 'package:space_news/widgets/list_cell.dart';
import '../../../models/iss/iss.dart';
import '../../../util/colors.dart';

class IssTimesTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IssModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: CustomScrollView(slivers: <Widget>[
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
                            center: LatLng(
                              0.0,
                              0.0,
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
                                  model.issLocation.coordinates[0],
                                  model.issLocation.coordinates[1],
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
                  : SliverList(
                      key: PageStorageKey(model.passTimesTitle(context)),
                      delegate: SliverChildBuilderDelegate(
                        _buildItem,
                        childCount: model.getSize,
                      ),
                    ),
            ]),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ScopedModelDescendant<IssModel>(builder: (context, child, model) {
      final PassTime passTime = model.getItem(1).passTimes[index];

      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                ListCell(
                  leading: Icon(Icons.timer, size: 42.0),
                  title: passTime.getDate,
                  subtitle: passTime.getDuration(context),
                ),
                const Divider(height: 0.0, indent: 96.0)
              ],
            ),
          ),
        ],
      );
    });
  }
}
