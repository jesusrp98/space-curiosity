import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../../data/models/spacex/details_capsule.dart';
import '../../general/expand_widget.dart';
import '../../general/row_item.dart';
import '../../general/scroll_page.dart';

/// CAPSULE PAGE VIEW
/// This view displays information about a specific capsule,
/// used in a NASA mission.
class CapsulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CapsuleModel>(
      builder: (context, model, child) => Scaffold(
            body: ScrollPage<CapsuleModel>.photos(
              title: FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.title_capsule',
                {'serial': model.id},
              ),
              photos: model.photos,
              children: <Widget>[
                SliverToBoxAdapter(child: _buildBody()),
              ],
            ),
          ),
    );
  }

  Widget _buildBody() {
    return Consumer<CapsuleModel>(
      builder: (context, model, child) => RowLayout.body(children: <Widget>[
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.model',
              ),
              model.capsule.name,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.status',
              ),
              model.capsule.getStatus,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.first_launched',
              ),
              model.capsule.getFirstLaunched(context),
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.launches',
              ),
              model.capsule.getLaunches,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.vehicle.splashings',
              ),
              model.capsule.getSplashings,
            ),
            Separator.divider(),
            if (model.capsule.hasMissions) ...[
              if (model.capsule.missions.length > 5) ...[
                for (var mission in model.capsule.missions.sublist(0, 5))
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.dialog.vehicle.mission',
                      {'number': mission.id.toString()},
                    ),
                    mission.name,
                  ),
                RowExpand(RowLayout(
                  children: <Widget>[
                    for (var mission in model.capsule.missions.sublist(5))
                      RowText(
                        FlutterI18n.translate(
                          context,
                          'spacex.dialog.vehicle.mission',
                          {'number': mission.id.toString()},
                        ),
                        mission.name,
                      ),
                  ],
                ))
              ] else
                for (var mission in model.capsule.missions)
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.dialog.vehicle.mission',
                      {'number': mission.id.toString()},
                    ),
                    mission.name,
                  ),
              Separator.divider()
            ],
            TextExpand(model.capsule.getDetails(context))
          ]),
    );
  }
}
