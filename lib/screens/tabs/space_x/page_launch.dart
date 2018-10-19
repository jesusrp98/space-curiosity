import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../models/rockets/core.dart';
import '../../../models/rockets/fairing.dart';
import '../../../models/rockets/launch.dart';
import '../../../models/rockets/rocket.dart';
import '../../../models/rockets/second_stage.dart';
import '../../../util/colors.dart';
import '../../../widgets/card_page.dart';
import '../../../widgets/details_dialog.dart';
import '../../../widgets/head_card_page.dart';
import '../../../widgets/hero_image.dart';
import '../../../widgets/row_item.dart';

/// LAUNCH PAGE CLASS
/// This class displays all information of a specific launch.
class LaunchPage extends StatefulWidget {
  final Launch _launch;

  LaunchPage(this._launch);

  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  static const List<String> _popupItems = [
    'Reddit campaign',
    'YouTube video',
    'Press kit',
    'Article',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Launch details'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (context) => _popupItems.map((f) {
                  return PopupMenuItem(value: f, child: Text(f));
                }).toList(),
            onSelected: (option) => openWeb(context, option),
          ),
        ],
      ),
      body: (_currentIndex == 0)
          ? _missionCard(context)
          : ((_currentIndex == 1)
              ? _firstStageCard(context)
              : _secondStageCard(context)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: const Text('Launch'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: const Text('Rocket'),
            icon: Icon(Icons.directions_car),
          ),
          BottomNavigationBarItem(
            title: const Text('Payload'),
            icon: Icon(Icons.timer),
          ),
        ],
      ),
    );
  }

  /// Method used for opening webs from the popup menu
  openWeb(BuildContext context, String option) async {
    final String url = widget._launch.links[_popupItems.indexOf(option)];

    if (url == null)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Unavailable link'),
              content: const Text(
                'Link has not been yet provided by the service. Please try again at a later time.',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    else
      await FlutterWebBrowser.openWebPage(
        url: url,
        androidToolbarColor: primaryColor,
      );
  }

  Widget _missionCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildExpandedHero(
        context: context,
        size: HeroImage.bigSize,
        url: widget._launch.getImageUrl,
        tag: widget._launch.getNumber,
        title: widget._launch.name,
      ),
      title: widget._launch.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget._launch.getLaunchDate,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          InkWell(
            onTap: () => showDialog(
                  context: context,
                  builder: (context) => DetailsDialog.launchpad(
                        id: widget._launch.launchpadId,
                        title: widget._launch.launchpadName,
                      ),
                ),
            child: Text(
              widget._launch.launchpadName,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    decoration: TextDecoration.underline,
                    color: secondaryText,
                  ),
            ),
          ),
        ],
      ),
      details: widget._launch.getDetails,
    );
  }

  Widget _firstStageCard(BuildContext context) {
    final Rocket rocket = widget._launch.rocket;

    return CardPage(
      title: 'ROCKET',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Rocket name', rocket.name),
          const SizedBox(height: 12.0),
          RowItem.textRow('Model', rocket.type),
          const SizedBox(height: 12.0),
          RowItem.textRow('Static fire date', widget._launch.getStaticFireDate),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Launch success', widget._launch.launchSuccess),
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
    final SecondStage secondStage = widget._launch.rocket.secondStage;
    final Fairing fairing = widget._launch.rocket.fairing;

    return CardPage(
      title: 'PAYLOAD',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Second stage model', secondStage.getBlock),
          (widget._launch.rocket.hasFairing)
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
        context,
        'Core serial',
        core.getId,
        DetailsDialog.core(id: core.getId, title: 'Core ${core.getId}'),
      ),
      const SizedBox(height: 12.0),
      RowItem.textRow('Model', core.getBlock),
      const SizedBox(height: 12.0),
      RowItem.iconRow('Reused', core.reused),
      const SizedBox(height: 12.0),
      (core.getLandingZone != 'Unknown')
          ? Column(children: <Widget>[
              RowItem.textRow('Landing type', core.getLandingType),
              const SizedBox(height: 12.0),
              RowItem.textRow('Landing zone', core.getLandingZone),
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
                context,
                'Capsule serial',
                payload.getCapsuleSerial,
                DetailsDialog.capsule(
                  id: payload.getCapsuleSerial,
                  title: 'Capsule ${payload.getCapsuleSerial}',
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
}
