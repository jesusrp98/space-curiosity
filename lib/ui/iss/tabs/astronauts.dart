import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:space_news/plugins/url_launcher/url_launcher.dart';

import '../../../data/models/iss/astronauts.dart';
import '../../general/cache_image.dart';
import '../../general/list_cell.dart';

/// ASTRONAUTS TAB
/// This view holds a list with all current astronauts living in space.
class AstronautsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AstronautsModel>(
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(slivers: <Widget>[
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
                  ? Center(child: CircularProgressIndicator())
                  : Swiper(
                      itemCount: model.getPhotosCount,
                      itemBuilder: (context, index) => CacheImage(
                        model.getPhoto(index),
                      ),
                      autoplay: true,
                      autoplayDelay: 6000,
                      duration: 750,
                      onTap: (index) async => await UrlUtils.open(
                        url: model.getPhoto(index),
                        androidToolbarColor: Theme.of(context).primaryColor,
                      ),
                    ),
            ),
          ),
          model.isLoading
              ? SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    _buildItem,
                    childCount: model.getItemCount,
                  ),
                ),
        ]),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Consumer<AstronautsModel>(
      builder: (context, model, child) {
        final Astronaut astronaut = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: const Icon(FontAwesomeIcons.userAstronaut, size: 42.0),
            title: astronaut.name,
            subtitle: astronaut.description(context),
          ),
          Separator.divider(indent: 74.0)
        ]);
      },
    );
  }
}
