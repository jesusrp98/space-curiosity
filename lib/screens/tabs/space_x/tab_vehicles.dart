import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../util/colors.dart';

import '../../../models/rockets/vehicle.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/list_cell.dart';
import 'page_capsule.dart';
import 'page_roadster.dart';
import 'page_rocket.dart';
import 'page_ship.dart';

class VehiclesTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _onRefresh(model),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.25,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text('Vehicles'),
                      background: Swiper(
                        itemCount: model.getImagesCount,
                        itemBuilder: _buildImage,
                        autoplay: true,
                        autoplayDelay: 10000,
                        duration: 1000,
                        curve: Curves.ease,
                        onTap: (index) => FlutterWebBrowser.openWebPage(
                              url: model.getImageUrl(index),
                              androidToolbarColor: primaryColor,
                            ),
                      ),
                    ),
                  ),
                  (model.isLoading)
                      ? SliverFillRemaining(
                          child: NativeLoadingIndicator(center: true),
                        )
                      : SliverList(
                          key: PageStorageKey('Vehicles'),
                          delegate: SliverChildBuilderDelegate(
                            _buildItem,
                            childCount: model.getSize,
                          ),
                        ),
                ],
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

  Widget _buildImage(BuildContext context, int index) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) => Image.network(
            model.getImageUrl(index),
            fit: BoxFit.cover,
          ),
    );
  }
}
