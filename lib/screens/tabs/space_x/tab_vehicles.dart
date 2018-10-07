import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/models/rockets/vehicle.dart';
import 'package:space_news/screens/tabs/space_x/vehicles.dart';
import 'package:space_news/widgets/hero_image.dart';
import 'package:space_news/widgets/list_cell.dart';

class VehiclesTab extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> _onRefresh(VehiclesModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) => ScopedModelDescendant<VehiclesModel>(
            builder: (context, child, model) => SafeArea(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () => _onRefresh(model),
                    child: StreamBuilder(
                      stream: model.loadData().asStream().distinct(),
                      builder: (BuildContext context, _) {
                        if (model.vehicles == null)
                          return NativeLoadingIndicator(
                            center: true,
                            text: Text("Loading..."),
                          );

                        if (model.vehicles.isEmpty)
                          return Center(child: Text("No launches Found"));

                        return ListView.builder(
                          itemCount: model.vehicles.length,
                          itemBuilder: _buildItem,
                        );
                      },
                    ),
                  ),
                ),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<VehiclesModel>(builder: (context, child, model) {
          final Vehicle vehicle = model.vehicles[index];
          return Column(
            children: <Widget>[
              ListCell(
                leading: HeroImage().buildHero(
                  context: context,
                  size: HeroImage.smallSize,
                  url: vehicle.getImageUrl,
                  tag: vehicle.id,
                  title: vehicle.name,
                ),
                title: vehicle.name,
                subtitle: vehicle.subtitle,
                trailing: VehicleStatus(vehicle.active),
//                onTap: () => Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (_) => LaunchPage(vehicle)),
//                    ),
              ),
              const Divider(height: 0.0, indent: 104.0)
            ],
          );
        })
      ],
    );
  }
}
