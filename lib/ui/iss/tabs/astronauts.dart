import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/models/iss/astronauts.dart';
import '../../general/cache_image.dart';
import '../../general/list_cell.dart';
import '../../general/separator.dart';

/// ASTRONAUTS TAB
/// This view holds a list with all current astronauts living in space.
class AstronautsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AstronautsModel>(
      builder: (context, child, model) => Scaffold(
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
                      ? NativeLoadingIndicator(center: true)
                      : Swiper(
                          itemCount: model.getPhotosCount,
                          itemBuilder: (context, index) => CacheImage(
                                model.getPhoto(index),
                              ),
                          autoplay: true,
                          autoplayDelay: 6000,
                          duration: 750,
                          onTap: (index) async =>
                              await FlutterWebBrowser.openWebPage(
                                url: model.getPhoto(index),
                                androidToolbarColor:
                                    Theme.of(context).primaryColor,
                              ),
                        ),
                ),
              ),
              model.isLoading
                  ? SliverFillRemaining(
                      child: NativeLoadingIndicator(center: true),
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
    return ScopedModelDescendant<AstronautsModel>(
      builder: (context, child, model) {
        final Astronaut astronaut = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: const Icon(FontAwesomeIcons.userAstronaut, size: 42.0),
            title: astronaut.name,
            subtitle: astronaut.description(context),
          ),
          Separator.divider(height: 0.0, indent: 74.0)
        ]);
      },
    );
  }
}
