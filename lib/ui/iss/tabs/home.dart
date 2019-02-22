import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/iss/iss_home.dart';
import '../../general/cache_image.dart';
import '../../general/list_cell.dart';
import '../../general/separator.dart';

class IssHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IssHomeModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    FlutterI18n.translate(context, 'iss.home.title'),
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
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<IssHomeModel>(
      builder: (context, child, model) => Column(
            children: <Widget>[
              ListCell(
                leading: const Icon(Icons.flight_takeoff, size: 42.0),
                title: model.launchedTitle(context),
                subtitle: model.launchedBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.public, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.altitude.title',
                ),
                subtitle: model.altitudeBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.update, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.orbit.title',
                ),
                subtitle: model.orbitBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.attach_money, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.project.title',
                ),
                subtitle: model.projectTitle(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.people, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.numbers.title',
                ),
                subtitle: model.numbersBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: const Icon(Icons.straighten, size: 42.0),
                title: FlutterI18n.translate(
                  context,
                  'iss.home.tab.specifications.title',
                ),
                subtitle: model.specificationsBody(context),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
            ],
          ),
    );
  }
}
