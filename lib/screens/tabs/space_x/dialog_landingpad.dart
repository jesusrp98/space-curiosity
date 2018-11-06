import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/landingpad.dart';
import '../../../util/colors.dart';
import '../../../widgets/row_item.dart';

class LandingpadDialog extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LandingpadModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.public),
                    onPressed: () => FlutterWebBrowser.openWebPage(
                          url: model.landingpad.url,
                          androidToolbarColor: primaryColor,
                        ),
                    tooltip: 'Wikipedia article',
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(model.id),
                  // background: (model.isLoading)
                  //     ? NativeLoadingIndicator(center: true)
                  //     : Swiper(
                  //         itemCount: model.getImagesCount,
                  //         itemBuilder: _buildImage,
                  //         autoplay: true,
                  //         autoplayDelay: 6000,
                  //         duration: 750,
                  //         onTap: (index) => FlutterWebBrowser.openWebPage(
                  //               url: model.getImageUrl(index),
                  //               androidToolbarColor: primaryColor,
                  //             ),
                  //       ),
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
    return ScopedModelDescendant<LandingpadModel>(
      builder: (context, child, model) => Scrollbar(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        model.landingpad.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow('Status', model.landingpad.getStatus),
                      const SizedBox(height: 12.0),
                      RowItem.textRow('Location', model.landingpad.location),
                      const SizedBox(height: 12.0),
                      RowItem.textRow('State', model.landingpad.state),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        'Coordinates',
                        model.landingpad.getCoordinates,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        'Landing type',
                        model.landingpad.type,
                      ),
                      const SizedBox(height: 12.0),
                      RowItem.textRow(
                        'Successful landings',
                        model.landingpad.getSuccessfulLandings,
                      ),
                      const Divider(height: 24.0),
                      Text(
                        model.landingpad.details,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: secondaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
