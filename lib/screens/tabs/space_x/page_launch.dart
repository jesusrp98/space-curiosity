//import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../../models/rockets/capsule_details.dart';
import '../../../models/rockets/core.dart';
import '../../../models/rockets/core_details.dart';
import '../../../models/rockets/fairing.dart';
import '../../../models/rockets/landingpad.dart';
import '../../../models/rockets/launch.dart';
import '../../../models/rockets/launchpad.dart';
import '../../../models/rockets/rocket.dart';
import '../../../models/rockets/second_stage.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/head_card_page.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/row_item.dart';
import 'dialog_capsule.dart';
import 'dialog_core.dart';
import 'dialog_landingpad.dart';
import 'dialog_launchpad.dart';

/// LAUNCH PAGE CLASS
/// This class displays all information of a specific launch.
class LaunchPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Launch _launch;
  static const List<String> _popupItems = [
    'Reddit campaign',
    'Official press kit',
    'Internet article',
  ];

  LaunchPage(this._launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) => SliverFab(
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floatingActionButton: (_launch.hasVideo)
                  ? FloatingActionButton(
                      child: const Icon(Icons.play_arrow),
                      tooltip: 'Watch replay',
                      onPressed: () => FlutterWebBrowser.openWebPage(
                            url: _launch.getVideo,
                            androidToolbarColor: primaryColor,
                          ),
                    )
                  : (_launch.tentativePrecision == 'hour')
                      ? FloatingActionButton(
                          child: const Icon(Icons.event),
                          tooltip: 'Add event',
                          // onPressed: () => Add2Calendar.addEvent2Cal(
                          //       Event(
                          //         title: _launch.name,
                          //         description: _launch.details,
                          //         location: _launch.launchpadName,
                          //         startDate: _launch.launchDate,
                          //         endDate: _launch.launchDate
                          //             .add(Duration(minutes: 30)),
                          //       ),
                          //     ),
                        )
                      : null,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[
                    PopupMenuButton<String>(
                      itemBuilder: (_) => _popupItems
                          .map((url) => PopupMenuItem(
                                value: url,
                                child: Text(url),
                                enabled: _launch
                                        .links[_popupItems.indexOf(url) + 1] !=
                                    null,
                              ))
                          .toList(),
                      onSelected: (url) => FlutterWebBrowser.openWebPage(
                            url: _launch.links[_popupItems.indexOf(url) + 1],
                            androidToolbarColor: primaryColor,
                          ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(_launch.name),
                    background: Swiper(
                      itemCount: _launch.getPhotosCount,
                      itemBuilder: _buildImage,
                      autoplay: true,
                      autoplayDelay: 6000,
                      duration: 750,
                      onTap: (index) => FlutterWebBrowser.openWebPage(
                            url: _launch.getPhoto(index),
                            androidToolbarColor: primaryColor,
                          ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      _missionCard(context),
                      const SizedBox(height: 8.0),
                      _firstStageCard(context),
                      const SizedBox(height: 8.0),
                      _secondStageCard(context),
                    ]),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _missionCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage.card(
        url: _launch.getImageUrl,
        tag: _launch.getNumber,
        onTap: (_launch.hasImage)
            ? () => FlutterWebBrowser.openWebPage(
                  url: _launch.getImageUrl,
                  androidToolbarColor: primaryColor,
                )
            : null,
      ),
      title: _launch.name,
      subtitle1: Text(
        _launch.getLaunchDate,
        style:
            Theme.of(context).textTheme.subhead.copyWith(color: secondaryText),
      ),
      subtitle2: InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ScopedModel<LaunchpadModel>(
                      model: LaunchpadModel(
                        _launch.launchpadId,
                        _launch.launchpadName,
                      )..loadData(),
                      child: LaunchpadDialog(),
                    ),
                fullscreenDialog: true,
              ),
            ),
        child: Text(
          _launch.launchpadName,
          style: Theme.of(context).textTheme.subhead.copyWith(
                decoration: TextDecoration.underline,
                color: secondaryText,
              ),
        ),
      ),
      details: _launch.getDetails,
    );
  }

  Widget _firstStageCard(BuildContext context) {
    final Rocket rocket = _launch.rocket;

    return CardPage(
      title: 'ROCKET',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Rocket name', rocket.name),
          const SizedBox(height: 12.0),
          RowItem.textRow('Model', rocket.type),
          const SizedBox(height: 12.0),
          RowItem.textRow('Static fire date', _launch.getStaticFireDate),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Launch success', _launch.launchSuccess),
          Column(
            children: rocket.firstStage
                .map((core) => _getCores(context, core))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _secondStageCard(BuildContext context) {
    final SecondStage secondStage = _launch.rocket.secondStage;
    final Fairing fairing = _launch.rocket.fairing;

    return CardPage(
      title: 'PAYLOAD',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Second stage model', secondStage.getBlock),
          (_launch.rocket.hasFairing)
              ? Column(
                  children: <Widget>[
                    const Divider(height: 24.0),
                    RowItem.iconRow('Fairings reused', fairing.reused),
                    const SizedBox(height: 12.0),
                    (fairing.recoveryAttempt == true)
                        ? Column(
                            children: <Widget>[
                              RowItem.iconRow(
                                  'Recovery success', fairing.recoverySuccess),
                              const SizedBox(height: 12.0),
                              RowItem.textRow('Recovery ship', fairing.ship),
                            ],
                          )
                        : RowItem.iconRow(
                            'Recovery attempt', fairing.recoveryAttempt),
                  ],
                )
              : const SizedBox(height: 0.0),
          Column(
            children: secondStage.payloads
                .map((payload) => _getPayload(context, payload))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _getCores(BuildContext context, Core core) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.dialogRow(
        context: context,
        title: 'Core serial',
        description: core.getId,
        screen: ScopedModel<CoreModel>(
          model: CoreModel(core.id)..loadData(),
          child: CoreDialog(),
        ),
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow('Model', core.getBlock),
      const SizedBox(height: 12.0),
      RowItem.iconRow('Reused', core.reused),
      const SizedBox(height: 12.0),
      (core.getLandingZone != 'Unknown')
          ? Column(children: <Widget>[
              RowItem.dialogRow(
                context: context,
                title: 'Landing zone',
                description: core.getLandingZone,
                screen: ScopedModel<LandingpadModel>(
                  model: LandingpadModel(core.landingZone)..loadData(),
                  child: LandingpadDialog(),
                ),
              ),
              const SizedBox(height: 12.0),
              RowItem.iconRow('Landing success', core.landingSuccess)
            ])
          : RowItem.iconRow('Landing attempt', core.landingIntent),
    ]);
  }

  Widget _getPayload(BuildContext context, Payload payload) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.textRow('Payload name', payload.getId),
      (payload.isNasaPayload)
          ? Column(children: <Widget>[
              const SizedBox(height: 12.0),
              RowItem.dialogRow(
                context: context,
                title: 'Capsule serial',
                description: payload.getCapsuleSerial,
                screen: ScopedModel<CapsuleModel>(
                  model: CapsuleModel(payload.capsuleSerial)..loadData(),
                  child: CapsuleDialog(),
                ),
              ),
              const SizedBox(height: 12.0),
              RowItem.iconRow('Reused', payload.reused),
              const SizedBox(height: 12.0)
            ])
          : const SizedBox(height: 12.0),
      RowItem.textRow('Manufacturer', payload.getManufacturer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Customer', payload.getCustomer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Nationality', payload.getNationality),
      const SizedBox(height: 12.0),
      RowItem.textRow('Mass', payload.getMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Orbit', payload.getOrbit),
    ]);
  }

  Widget _buildImage(BuildContext context, int index) {
    return CachedNetworkImage(
      imageUrl: _launch.getPhoto(index),
      errorWidget: const Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 100),
      fit: BoxFit.cover,
    );
  }
}
