import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/spacex_home.dart';
import '../../../util/colors.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/list_cell.dart';
import '../../../widgets/spacex_home_detail.dart';
import 'page_launch.dart';

class SpacexHomeTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> _onRefresh(SpacexHomeModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SpacexHomeModel>(
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
                      title: Text('Welcome to SpaceX'),
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
                      : SliverToBoxAdapter(child: _buildBody())
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<SpacexHomeModel>(
      builder: (context, child, model) {
        return Column(
          children: <Widget>[
            Container(height: 16.0),
            Text(
              model.countdown,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontFamily: 'RobotoMono'),
            ),
            Container(height: 8.0),
            ListCell(
              leading: HeroImage().buildHero(
                context: context,
                size: HeroImage.smallSize,
                url: model.launch.getImageUrl,
                tag: model.launch.getNumber,
                title: model.launch.name,
              ),
              title: model.launch.name,
              subtitle: model.launch.getLaunchDate,
              trailing: MissionNumber(model.launch.getNumber),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LaunchPage(model.launch)),
                  ),
            ),
            const Divider(height: 0.0),
            SpacexHomeDetail(
              icon: Icons.public,
              title: model.vehicle,
              subtitle: model.payload,
            ),
            const Divider(height: 0.0, indent: 74.0),
            SpacexHomeDetail(
              icon: Icons.calendar_today,
              title: 'Launch date',
              subtitle: model.launchDate,
            ),
            const Divider(height: 0.0, indent: 74.0),
            SpacexHomeDetail(
              icon: Icons.location_on,
              title: 'Launch site',
              subtitle: model.launchpad,
            ),
            const Divider(height: 0.0, indent: 74.0),
            SpacexHomeDetail(
              icon: Icons.timer,
              title: 'Static fire date',
              subtitle: model.staticFire,
            ),
            const Divider(height: 0.0, indent: 74.0),
            SpacexHomeDetail(
              icon: Icons.directions_boat,
              title: 'Fairings',
              subtitle: model.fairings,
            ),
            const Divider(height: 0.0, indent: 74.0),
            SpacexHomeDetail(
              icon: Icons.flight_land,
              title: 'Reused parts',
              subtitle: model.landings,
            ),
          ],
        );
      },
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    return ScopedModelDescendant<SpacexHomeModel>(
      builder: (context, child, model) => CachedNetworkImage(
            imageUrl: model.getPhoto(index),
            errorWidget: const Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 100),
            fit: BoxFit.cover,
          ),
    );
  }
}
