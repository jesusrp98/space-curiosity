import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/details_capsule.dart';
import '../../../models/rockets/mission_item.dart';
import '../../../util/colors.dart';
import '../../../widgets/row_item.dart';
import '../../../widgets/separator.dart';

class CapsuleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.title_capsule',
                    {'serial': model.id},
                  )),
                  background: model.isLoading
                      ? NativeLoadingIndicator(center: true)
                      : Swiper(
                          itemCount: model.getPhotosCount,
                          itemBuilder: _buildImage,
                          autoplay: true,
                          autoplayDelay: 6000,
                          duration: 750,
                          onTap: (index) async =>
                              await FlutterWebBrowser.openWebPage(
                                url: model.getPhoto(index),
                                androidToolbarColor: primaryColor,
                              ),
                        ),
                ),
              ),
              model.isLoading
                  ? SliverFillRemaining(
                      child: NativeLoadingIndicator(center: true),
                    )
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              RowItem.textRow(
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.model',
                ),
                model.capsule.name,
              ),
              Separator.spacer(),
              RowItem.textRow(
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.status',
                ),
                model.capsule.getStatus,
              ),
              Separator.spacer(),
              RowItem.textRow(
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.first_launched',
                ),
                model.capsule.getFirstLaunched(context),
              ),
              Separator.spacer(),
              RowItem.textRow(
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.launches',
                ),
                model.capsule.getLaunches,
              ),
              Separator.spacer(),
              RowItem.textRow(
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.splashings',
                ),
                model.capsule.getLandings,
              ),
              Separator.divider(),
              model.capsule.hasMissions
                  ? Column(children: <Widget>[
                      Column(
                        children: model.capsule.missions
                            .map((mission) => _getMission(context, mission))
                            .toList(),
                      ),
                      Separator.divider(),
                    ])
                  : Separator.none(),
              Separator.divider(),
              Text(
                model.capsule.getDetails(context),
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: secondaryText),
              ),
            ]),
          ),
    );
  }

  Column _getMission(BuildContext context, MissionItem mission) {
    return Column(children: <Widget>[
      RowItem.textRow(
        FlutterI18n.translate(
          context,
          'spacex.dialog.vehicle.mission',
          {'number': mission.id.toString()},
        ),
        mission.name,
      ),
    ]);
  }

  Widget _buildImage(BuildContext context, int index) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => CachedNetworkImage(
            imageUrl: model.getPhoto(index),
            errorWidget: const Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 100),
            fit: BoxFit.cover,
          ),
    );
  }
}
