import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../models/rockets/rocket_info.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/row_item.dart';

/// ROCKET PAGE CLASS
/// This class represent a rocket page. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RocketInfo _rocket;

  RocketPage(this._rocket);

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
                    url: _rocket.url, androidToolbarColor: primaryColor),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.vehicle.menu.wikipedia',
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(_rocket.name),
              background: Swiper(
                itemCount: _rocket.getPhotosCount,
                itemBuilder: _buildImage,
                autoplay: true,
                autoplayDelay: 6000,
                duration: 750,
                onTap: (index) => FlutterWebBrowser.openWebPage(
                      url: _rocket.getPhoto(index),
                      androidToolbarColor: primaryColor,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                _rocketCard(context),
                const SizedBox(height: 8.0),
                _specsCard(context),
                const SizedBox(height: 8.0),
                _payloadsCard(context),
                const SizedBox(height: 8.0),
                _enginesCard(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rocketCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.description.title',
      ),
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              DateTime.now().isAfter(_rocket.firstFlight)
                  ? 'spacex.vehicle.rocket.description.launch_maiden'
                  : 'spacex.vehicle.rocket.description.launch_scheduled',
            ),
            _rocket.getFullFirstFlight,
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.description.active',
            ),
            _rocket.active,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.description.launch_cost',
            ),
            _rocket.getLaunchCost,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.description.success_rate',
            ),
            _rocket.getSuccessRate,
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.description.reusable',
            ),
            _rocket.reusable,
          ),
          const Divider(height: 24.0),
          Text(
            _rocket.description,
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
        'spacex.vehicle.rocket.specifications.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.specifications.rocket_stages',
            ),
            _rocket.getStages(context),
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.specifications.fairing_height',
            ),
            _rocket.fairingHeight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.specifications.fairing_diameter',
            ),
            _rocket.fairingDiameter,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.specifications.height',
            ),
            _rocket.getHeight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.specifications.diameter',
            ),
            _rocket.getDiameter,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.specifications.mass',
            ),
            _rocket.getMass(context),
          ),
        ],
      ),
    );
  }

  Widget _payloadsCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.capability.title',
      ),
      body: Column(
        children: _combineList(_rocket.payloadWeights
            .map((payloadWeight) => _getPayloadWeight(payloadWeight))
            .toList()),
      ),
    );
  }

  List<Widget> _getPayloadWeight(PayloadWeight payloadWeight) {
    return <Widget>[
      RowItem.textRow(payloadWeight.name, payloadWeight.getMass),
      const SizedBox(height: 12.0),
    ];
  }

  List<Widget> _combineList(List<List<Widget>> map) {
    final List<Widget> finalList = List();

    map.forEach((payloadWeight) => finalList.addAll(payloadWeight));

    return finalList..removeLast();
  }

  Widget _enginesCard(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.engines.title',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.model',
            ),
            _rocket.getEngine,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.engines_first_stage',
            ),
            _rocket.firstStageEngines,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.engines_second_stage',
            ),
            _rocket.secondStageEngines,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.fuel',
            ),
            _rocket.getFuel,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.oxidizer',
            ),
            _rocket.getOxidizer,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.thrust_weight',
            ),
            _rocket.getThrustToWeight,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.thrust_sea',
            ),
            _rocket.getEngineThrustSea,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.thrust_vacuum',
            ),
            _rocket.getEngineThrustVacuum,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    CachedNetworkImage photo = CachedNetworkImage(
      imageUrl: _rocket.getPhoto(index),
      errorWidget: const Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 100),
      fit: BoxFit.cover,
    );
    if (index == 0)
      return Hero(tag: _rocket.id, child: photo);
    else
      return photo;
  }
}
