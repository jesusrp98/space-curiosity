import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/screens/tabs/space_x/search_vehicles.dart';

import '../../../models/rockets/info_vehicle.dart';
import '../../../util/colors.dart';
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
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(FlutterI18n.translate(
                        context,
                        'spacex.vehicle.title',
                      )),
                      background: (model.isLoading)
                          ? NativeLoadingIndicator(center: true)
                          : Swiper(
                              itemCount: model.getPhotosCount,
                              itemBuilder: _buildImage,
                              autoplay: true,
                              autoplayDelay: 6000,
                              duration: 750,
                              onTap: (index) => FlutterWebBrowser.openWebPage(
                                    url: model.getPhoto(index),
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
                            childCount: model.getItemCount,
                          ),
                        ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.search),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              onPressed: () => Navigator.of(context).push(
                    searchVehicles(context, model.items),
                  ),
            ),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<VehiclesModel>(builder: (context, child, model) {
          final Vehicle vehicle = model.getItem(index);
          return Column(
            children: <Widget>[
              ListCell(
                leading: HeroImage.list(
                  url: vehicle.getProfilePhoto,
                  tag: vehicle.id,
                ),
                title: vehicle.name,
                subtitle: vehicle.subtitle(context),
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
              const Divider(height: 0.0, indent: 96.0)
            ],
          );
        })
      ],
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) => CachedNetworkImage(
            imageUrl: model.getPhoto(index),
            errorWidget: const Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 100),
            fit: BoxFit.cover,
          ),
    );
  }
}
