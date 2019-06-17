import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../../data/models/spacex/launch.dart';
import '../../general/hero_image.dart';
import '../../general/list_cell.dart';
import '../../general/scroll_page.dart';
import '../pages/launch.dart';
import '../search/launches.dart';

/// LAUNCHES TAB VIEW
/// This tab holds information a specific type of launches,
/// upcoming or latest, defined by the model.
class LaunchesTab extends StatelessWidget {
  final int title;

  LaunchesTab(this.title);

  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchesModel>(
      builder: (context, model, child) => Scaffold(
            body: ScrollPage<LaunchesModel>.tab(
              context: context,
              photos: model.photos,
              title: FlutterI18n.translate(
                context,
                title == 0 ? 'spacex.upcoming.title' : 'spacex.latest.title',
              ),
              children: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    _buildLaunch,
                    childCount: model.getItemCount,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.search),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              onPressed: () => Navigator.of(context).push(
                    searchLaunches(context, model.items),
                  ),
            ),
          ),
    );
  }

  Widget _buildLaunch(BuildContext context, int index) {
    return Consumer<LaunchesModel>(
      builder: (context, model, child) {
        final Launch launch = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: HeroImage.list(
              url: launch.getPatchUrl,
              tag: launch.getNumber,
            ),
            title: launch.name,
            subtitle: launch.getLaunchDate(context),
            trailing: MissionNumber(launch.getNumber),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaunchPage(launch)),
                ),
          ),
          Separator.divider(indent: 81)
        ]);
      },
    );
  }
}
