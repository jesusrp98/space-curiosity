import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/core_details.dart';
import '../../../models/rockets/launchpad.dart';
import '../../../models/rockets/spacex_home.dart';
import '../../../util/colors.dart';
import '../../../widgets/list_cell.dart';
import 'dialog_core.dart';
import 'dialog_launchpad.dart';
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
            LaunchCountdown(model),
            Container(height: 16.0),
            const Divider(height: 0.0),
            ListCell(
              leading: const Icon(Icons.public, size: 42.0),
              title: model.vehicle,
              subtitle: model.payload,
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LaunchPage(model.launch)),
                  ),
            ),
            const Divider(height: 0.0, indent: 74.0),
            ListCell(
              leading: const Icon(Icons.today, size: 42.0),
              title: 'Launch date',
              subtitle: model.launchDate,
            ),
            const Divider(height: 0.0, indent: 74.0),
            ListCell(
              leading: const Icon(Icons.location_on, size: 42.0),
              title: 'Launch site',
              subtitle: model.launchpad,
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScopedModel<LaunchpadModel>(
                            model: LaunchpadModel(
                              model.launch.launchpadId,
                              model.launch.launchpadName,
                            )..loadData(),
                            child: LaunchpadDialog(),
                          ),
                      fullscreenDialog: true,
                    ),
                  ),
            ),
            const Divider(height: 0.0, indent: 74.0),
            ListCell(
              leading: const Icon(Icons.timer, size: 42.0),
              title: 'Static fire date',
              subtitle: model.staticFire,
            ),
            const Divider(height: 0.0, indent: 74.0),
            ListCell(
              leading: const Icon(Icons.directions_boat),
              title: 'Fairings',
              subtitle: model.fairings,
            ),
            const Divider(height: 0.0, indent: 74.0),
            ListCell(
              leading: const Icon(Icons.autorenew, size: 42.0),
              title: 'Reused parts',
              subtitle: model.landings,
              onTap: (model.launch.rocket.firstStage[0].id == null)
                  ? null
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScopedModel<CoreModel>(
                                model: CoreModel(
                                  model
                                      .launch
                                      .rocket
                                      .firstStage[Random().nextInt(model
                                          .launch.rocket.firstStage.length)]
                                      .id,
                                )..loadData(),
                                child: CoreDialog(),
                              ),
                          fullscreenDialog: true,
                        ),
                      ),
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
