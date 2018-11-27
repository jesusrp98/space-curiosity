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
                  'spacex.other.menu.wikipedia',
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
                _firstStage(context),
                const SizedBox(height: 8.0),
                _secondStage(context),
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
              'spacex.vehicle.rocket.description.launch_maiden',
            ),
            _rocket.getFullFirstFlight,
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
            _rocket.getSuccessRate(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.description.active',
            ),
            _rocket.active,
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
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.fairing_height',
            ),
            _rocket.secondStage.fairingHeight(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.fairing_diameter',
            ),
            _rocket.secondStage.fairingDiameter(context),
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
        children: _rocket.payloadWeights
            .map(
              (mission) => _getPayloadWeight(
                    context,
                    _rocket.payloadWeights,
                    mission,
                  ),
            )
            .toList(),
      ),
    );
  }

  Column _getPayloadWeight(
    BuildContext context,
    List payloadWeights,
    payloadWeight,
  ) {
    return Column(
      children: <Widget>[
        RowItem.textRow(
          payloadWeight.name,
          payloadWeight.getMass,
        ),
      ]..add(
          payloadWeight != payloadWeights.last
              ? const SizedBox(height: 12.0)
              : Container(),
        ),
    );
  }

  Widget _firstStage(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.stage_first',
      ),
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.fuel_amount',
            ),
            _rocket.firstStage.getFuelAmount(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.engines',
            ),
            _rocket.firstStage.getEngines(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.reusable',
            ),
            _rocket.firstStage.reusable,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.thrust_sea',
            ),
            _rocket.firstStage.getThrustSea,
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.thrust_vacuum',
            ),
            _rocket.firstStage.getThrustVacuum,
          ),
        ],
      ),
    );
  }

  Widget _secondStage(context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.stage_second',
      ),
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.fuel_amount',
            ),
            _rocket.secondStage.getFuelAmount(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.engines',
            ),
            _rocket.secondStage.getEngines(context),
          ),
          const SizedBox(height: 12.0),
          RowItem.iconRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.stage.reusable',
            ),
            _rocket.secondStage.reusable,
          ),
          const Divider(height: 24.0),
          RowItem.textRow(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.rocket.engines.thrust_vacuum',
            ),
            _rocket.secondStage.getThrustVacuum,
          ),
        ],
      ),
    );
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
            _rocket.getEngineThrustToWeight(context),
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
