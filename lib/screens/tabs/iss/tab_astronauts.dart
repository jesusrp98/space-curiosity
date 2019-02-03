import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/iss/astronauts.dart';
import '../../../widgets/list_cell.dart';
import '../../../widgets/separator.dart';

class IssAstronautsTab extends StatelessWidget {
  Future<Null> _onRefresh(AstronautsModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AstronautsModel>(
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
                      FlutterI18n.translate(context, 'iss.astronauts.title'),
                    ),
                    background: model.isLoading
                        ? NativeLoadingIndicator(center: true)
                        // TODO add swiper header
                        // : FlutterMap(
                        //     options: MapOptions(
                        //       center: LatLng(0.0, 0.0),
                        //       zoom: 1.0,
                        //       minZoom: 1.0,
                        //       maxZoom: 5.0,
                        //     ),
                        //     layers: <LayerOptions>[
                        //       TileLayerOptions(
                        //         urlTemplate:
                        //             'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                        //         subdomains: ['a', 'b', 'c', 'd'],
                        //         backgroundColor: Theme.of(context).primaryColor,
                        //       ),
                        //       MarkerLayerOptions(
                        //         markers: <Marker>[
                        //           Marker(
                        //             width: 45.0,
                        //             height: 45.0,
                        //             point: LatLng(
                        //               model.issLocation.coordinates[0],
                        //               model.issLocation.coordinates[1],
                        //             ),
                        //             builder: (_) => const Icon(
                        //                   Icons.location_on,
                        //                   color: Colors.red,
                        //                   size: 45.0,
                        //                 ),
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        : Separator.none(),
                  ),
                ),
                model.isLoading
                    ? SliverFillRemaining(
                        child: NativeLoadingIndicator(center: true),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          _buildItem,
                          childCount: model.getItemCount,
                        ),
                      ),
              ]),
            ),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ScopedModelDescendant<AstronautsModel>(
      builder: (context, child, model) {
        final Astronaut astronaut = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: const Icon(FontAwesomeIcons.userAstronaut, size: 42.0),
            title: astronaut.name,
            subtitle: astronaut.description(context),
          ),
          Separator.divider(height: 0.0, indent: 74.0)
        ]);
      },
    );
  }
}
