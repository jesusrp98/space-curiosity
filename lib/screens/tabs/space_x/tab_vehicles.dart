import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/vehicle.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/list_cell.dart';
import 'page_capsule.dart';
import 'page_roadster.dart';
import 'page_ship.dart';
import 'page_rocket.dart';

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
      builder: (context, child, model) => RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _onRefresh(model),
            child: model.isLoading
                ? NativeLoadingIndicator(center: true)
                : Scrollbar(
                    child: ListView.builder(
                      key: PageStorageKey('vehicles'),
                      itemCount: model.getSize,
                      itemBuilder: _buildItem,
                    ),
                  ),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<VehiclesModel>(builder: (context, child, model) {
          final Vehicle vehicle = model.list[index];
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
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => (vehicle.type == 'rocket')
                            ? RocketPage(vehicle)
                            : (vehicle.type == 'capsule')
                                ? CapsulePage(vehicle)
                                : (vehicle.type == 'ship')
                                    ? ShipPage(vehicle)
                                    : RoadsterPage(vehicle),
                      ),
                    ),
              ),
              const Divider(height: 0.0, indent: 104.0)
            ],
          );
        })
      ],
    );
  }
}
