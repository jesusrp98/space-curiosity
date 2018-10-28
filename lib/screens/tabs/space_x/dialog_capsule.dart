import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/widgets/row_item.dart';

import '../../../models/rockets/capsule_details.dart';
import '../../../util/colors.dart';

class CapsuleDialog extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Capsule ${model.capsule.serial}'),
                  background: (model.isLoading)
                      ? NativeLoadingIndicator(center: true)
                      : Swiper(
                          itemCount: model.getImagesCount,
                          itemBuilder: _buildImage,
                          autoplay: true,
                          autoplayDelay: 6000,
                          duration: 750,
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
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Scrollbar(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      RowItem.textRow('Model', model.capsule.name),
                      const SizedBox(height: 8.0),
                      RowItem.textRow('Status', model.capsule.getStatus),
                      const SizedBox(height: 8.0),
                      RowItem.textRow(
                        'First launched',
                        model.capsule.getFirstLaunched,
                      ),
                      const SizedBox(height: 8.0),
                      RowItem.textRow('Launches', model.capsule.getLaunches),
                      const SizedBox(height: 8.0),
                      RowItem.textRow('Splashings', model.capsule.getLandings),
                      const SizedBox(height: 8.0),
                      Text(
                        model.capsule.getMissions,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.0, color: primaryText),
                      ),
                      const Divider(height: 24.0),
                      Text(
                        model.capsule.details,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15.0, color: secondaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => CachedNetworkImage(
            imageUrl: model.getImageUrl(index),
            errorWidget: const Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 100),
            fit: BoxFit.cover,
          ),
    );
  }
}
