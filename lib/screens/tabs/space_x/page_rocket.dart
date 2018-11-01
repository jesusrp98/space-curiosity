import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                onPressed: () async => await FlutterWebBrowser.openWebPage(
                    url: _rocket.url, androidToolbarColor: primaryColor),
                tooltip: 'Wikipedia article',
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
                      url: _rocket.getPhotoUrl(index),
                      androidToolbarColor: primaryColor,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                _rocketCard(),
                const SizedBox(height: 8.0),
                _specsCard(),
                const SizedBox(height: 8.0),
                _payloadsCard(),
                const SizedBox(height: 8.0),
                _enginesCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rocketCard() {
    return CardPage(
      title: 'DESCRIPTION',
      body: Column(
        children: <Widget>[
          RowItem.textRow(
              (DateTime.now().isAfter(_rocket.firstFlight))
                  ? 'Maiden launch'
                  : 'Scheduled maiden launch',
              _rocket.getFullFirstFlight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Launch cost', _rocket.getLaunchCost),
          const SizedBox(height: 12.0),
          RowItem.textRow('Success rate', _rocket.getSuccessRate),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Reusable', _rocket.reusable),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Active', _rocket.active),
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

  Widget _specsCard() {
    return CardPage(
      title: 'SPECIFICATIONS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Rocket stages', _rocket.getStages),
          const Divider(height: 24.0),
          RowItem.textRow('Fairing height', _rocket.fairingHeight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Fairing diameter', _rocket.fairingDiameter),
          const Divider(height: 24.0),
          RowItem.textRow('Height', _rocket.getHeight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Diameter', _rocket.getDiameter),
          const SizedBox(height: 12.0),
          RowItem.textRow('Total mass', _rocket.getMass),
        ],
      ),
    );
  }

  Widget _payloadsCard() {
    return CardPage(
      title: 'CAPABILITY',
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

  Widget _enginesCard() {
    return CardPage(
      title: 'ENGINES',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Engine model', _rocket.getEngine),
          const SizedBox(height: 12.0),
          RowItem.textRow('First stage engines', _rocket.firstStageEngines),
          const SizedBox(height: 12.0),
          RowItem.textRow('Second stage engines', _rocket.secondStageEngines),
          const Divider(height: 24.0),
          RowItem.textRow('Primary fuel', _rocket.getFuel),
          const SizedBox(height: 12.0),
          RowItem.textRow('Oxidizer', _rocket.getOxidizer),
          const Divider(height: 24.0),
          RowItem.textRow('Thrust to weight', _rocket.getThrustToWeight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Sea level thrust', _rocket.getEngineThrustSea),
          const SizedBox(height: 12.0),
          RowItem.textRow('Vacuum thrust', _rocket.getEngineThrustVacuum),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    CachedNetworkImage photo = CachedNetworkImage(
      imageUrl: _rocket.getPhotoUrl(index),
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
