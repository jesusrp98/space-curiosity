import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
                // actions: <Widget>[
                //   PopupMenuButton<String>(
                //     itemBuilder: (context) => _popupItems
                //         .map((f) => PopupMenuItem(value: f, child: Text(f)))
                //         .toList(),
                //     onSelected: (option) => FlutterWebBrowser.openWebPage(
                //           url: model
                //               .company.links[_popupItems.indexOf(option)],
                //           androidToolbarColor: primaryColor,
                //         ),
                //   ),
                // ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  // title: Text('About ${model.company.name}'),
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
                      // Text(
                      //   model.company.fullName,
                      //   style: Theme.of(context).textTheme.subhead,
                      // ),
                      // Container(height: 8.0),
                      // Text(
                      //   model.company.getFounderDate,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .subhead
                      //       .copyWith(color: secondaryText),
                      // ),
                      // Container(height: 12.0),
                      // RowItem.textRow('CEO', model.company.ceo),
                      // Container(height: 12.0),
                      // RowItem.textRow('CTO', model.company.cto),
                      // Container(height: 12.0),
                      // RowItem.textRow('COO', model.company.coo),
                      // Container(height: 12.0),
                      // RowItem.textRow('Valuation', model.company.getValuation),
                      // Container(height: 12.0),
                      // RowItem.textRow('Location', model.company.getLocation),
                      // Container(height: 12.0),
                      // RowItem.textRow('Employees', model.company.getEmployees),
                      // Container(height: 12.0),
                      // Text(
                      //   model.company.details,
                      //   textAlign: TextAlign.justify,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .subhead
                      //       .copyWith(color: secondaryText),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
