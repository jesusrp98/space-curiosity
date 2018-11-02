import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../models/rockets/capsule_info.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/row_item.dart';

/// CAPSULE PAGE CLASS
/// This class represent a capsule page. It displays CapsuleInfo's specs.
class CapsulePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CapsuleInfo _capsule;

  CapsulePage(this._capsule);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            floating: false,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.public),
                onPressed: () async => await FlutterWebBrowser.openWebPage(
                    url: _capsule.url, androidToolbarColor: primaryColor),
                tooltip: 'Wikipedia article',
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(_capsule.name),
              background: Swiper(
                itemCount: _capsule.getPhotosCount,
                itemBuilder: _buildImage,
                autoplay: true,
                autoplayDelay: 6000,
                duration: 750,
                onTap: (index) => FlutterWebBrowser.openWebPage(
                      url: _capsule.getPhoto(index),
                      androidToolbarColor: primaryColor,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                _capsuleCard(),
                const SizedBox(height: 8.0),
                _specsCard(),
                const SizedBox(height: 8.0),
                _thrustersCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _capsuleCard() {
    return CardPage(
      title: 'DESCRIPTION',
      body: Column(
        children: <Widget>[
          RowItem.textRow(
              (DateTime.now().isAfter(_capsule.firstFlight))
                  ? 'Maiden launch'
                  : 'Scheduled maiden launch',
              _capsule.getFullFirstFlight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Crew capacity', _capsule.getCrew),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Reusable', _capsule.reusable),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Active', _capsule.active),
          const Divider(height: 24.0),
          Text(
            _capsule.description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15.0, color: secondaryText),
          )
        ],
      ),
    );
  }

  Widget _specsCard() {
    return CardPage(
      title: 'SPECIFICATIONS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Launch payload', _capsule.getLaunchMass),
          const SizedBox(height: 12.0),
          RowItem.textRow('Return paylaod', _capsule.getReturnMass),
          const Divider(height: 24.0),
          RowItem.textRow('Height', _capsule.getHeight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Diameter', _capsule.getDiameter),
          const SizedBox(height: 12.0),
          RowItem.textRow('Dry mass', _capsule.getMass),
        ],
      ),
    );
  }

  Widget _thrustersCard() {
    return CardPage(
      title: 'THRUSTERS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Thruster systems', _capsule.getThrusters),
          Column(
            children: _capsule.thrusters
                .map((thruster) => _getThruster(thruster))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _getThruster(Thruster thruster) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.textRow('Thruster name', thruster.name),
      const SizedBox(height: 12.0),
      RowItem.textRow('Amount', thruster.getAmount),
      const SizedBox(height: 12.0),
      RowItem.textRow('Primary fuel', thruster.getFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Oxidizer', thruster.getOxidizer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Thrust', thruster.getThrust),
    ]);
  }

  Widget _buildImage(BuildContext context, int index) {
    CachedNetworkImage photo = CachedNetworkImage(
      imageUrl: _capsule.getPhoto(index),
      errorWidget: const Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 100),
      fit: BoxFit.cover,
    );
    if (index == 0)
      return Hero(tag: _capsule.id, child: photo);
    else
      return photo;
  }
}
