import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../models/rockets/info_capsule.dart';
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
                onPressed: () => FlutterWebBrowser.openWebPage(
                      url: _capsule.url,
                      androidToolbarColor: primaryColor,
                    ),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.other.menu.wikipedia',
                ),
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
                _capsuleCard(context),
                const SizedBox(height: 8.0),
                _specsCard(context),
                const SizedBox(height: 8.0),
                _thrustersCard(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _capsuleCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.description.title',
      ),
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.description.launch_maiden',
            ),
            _capsule.getFullFirstFlight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.description.crew_capacity',
            ),
            _capsule.getCrew(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.description.active',
            ),
            _capsule.active,
          ),
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

  Widget _specsCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.specifications.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.specifications.payload_launch',
            ),
            _capsule.getLaunchMass,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.specifications.payload_return',
            ),
            _capsule.getReturnMass,
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.description.reusable',
            ),
            _capsule.reusable,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.specifications.height',
            ),
            _capsule.getHeight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.specifications.diameter',
            ),
            _capsule.getDiameter,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.specifications.mass',
            ),
            _capsule.getMass(context),
          ),
        ],
      ),
    );
  }

  Widget _thrustersCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.thruster.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.capsule.thruster.systems',
              ),
              _capsule.getThrusters),
          Column(
            children: _capsule.thrusters
                .map((thruster) => _getThruster(context, thruster))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _getThruster(context, Thruster thruster) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.textRow(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.name',
        ),
        thruster.name,
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.amount',
        ),
        thruster.getAmount,
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.fuel',
        ),
        thruster.getFuel,
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.oxidizer',
        ),
        thruster.getOxidizer,
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.thrust',
        ),
        thruster.getThrust,
      ),
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
