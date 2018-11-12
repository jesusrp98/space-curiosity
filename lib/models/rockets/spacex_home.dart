import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';
import 'launch.dart';

class SpacexHomeModel extends QuerryModel {
  Launch launch;

  @override
  Future loadData() async {
    final response = await http.get(Url.nextLaunch);
    items.clear();

    if (photos.isEmpty) photos.addAll(Url.spacexHomeScreen);
    photos.shuffle();
    launch = Launch.fromJson(json.decode(response.body));

    loadingState(false);
  }

  String vehicle(context) =>
      '${FlutterI18n.translate(context, 'spacex.home.tab.mission.title')} ${launch.rocket.name}';

  String payload(context) {
    String aux =
        '${FlutterI18n.translate(context, 'spacex.home.tab.mission.body')} ';

    for (int i = 0; i < launch.rocket.secondStage.payloads.length; ++i)
      aux +=
          '${launch.rocket.secondStage.payloads[i].id} to ${launch.rocket.secondStage.payloads[i].orbit} orbit' +
              ((i + 1 == launch.rocket.secondStage.payloads.length)
                  ? '.'
                  : ', ');

    return aux;
  }

  String launchDate(context) =>
      '${FlutterI18n.translate(context, 'spacex.home.tab.date.body')} ${launch.getLaunchDate}.';

  String launchpad(context) =>
      '${FlutterI18n.translate(context, 'spacex.home.tab.launchpad.body')} ${launch.launchpadName}.';

  String staticFire(context) => launch.staticFireDate == null
      ? FlutterI18n.translate(context, 'spacex.home.tab.static_fire.body_null')
      : '${FlutterI18n.translate(context, 'spacex.home.tab.static_fire.body')} ${launch.getStaticFireDate}.';

  String fairings(context) =>
      '${launch.rocket.fairing.reused ? FlutterI18n.translate(context, 'spacex.home.tab.fairings.body_reused') : FlutterI18n.translate(context, 'spacex.home.tab.fairings.body_new')}, ${launch.rocket.fairing.recoveryAttempt ? FlutterI18n.translate(context, 'spacex.home.tab.fairings.body_catched') + ' ' + launch.rocket.fairing.ship + '.' : FlutterI18n.translate(context, 'spacex.home.tab.fairings.body_dispensed')}';

  String landings(context) {
    String aux = '';
    List<String> cores = [
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.booster'),
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.side_core'),
      FlutterI18n.translate(context, 'spacex.home.tab.first_stage.side_core'),
    ];

    for (int i = 0; i < launch.rocket.firstStage.length; ++i)
      aux += cores[i] +
          ' ' +
          (launch.rocket.firstStage[i].reused
              ? FlutterI18n.translate(
                  context, 'spacex.home.tab.first_stage.body_reused')
              : FlutterI18n.translate(
                  context, 'spacex.home.tab.first_stage.body_new')) +
          ', ' +
          (launch.rocket.firstStage[i].landingIntent
              ? FlutterI18n.translate(
                      context, 'spacex.home.tab.first_stage.body_catched') +
                  ' ' +
                  launch.rocket.firstStage[i].landingZone +
                  ' (' +
                  launch.rocket.firstStage[i].landingType +
                  ').'
              : FlutterI18n.translate(
                  context, 'spacex.home.tab.first_stage.body_dispended')) +
          ((i + 1 == launch.rocket.firstStage.length) ? '' : '\n');

    return aux;
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;
  final DateTime launchDate;

  Countdown({Key key, this.animation, this.launchDate})
      : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    return Text(
      getTimer(launchDate.difference(DateTime.now())),
      style: Theme.of(context)
          .textTheme
          .headline
          .copyWith(fontFamily: 'RobotoMono'),
    );
  }

  String getTimer(Duration d) =>
      'T' +
      (d.isNegative ? '+' : '-') +
      d.inDays.toString().padLeft(2, '0') +
      'd:' +
      (d.inHours - d.inDays * Duration.hoursPerDay).toString().padLeft(2, '0') +
      'h:' +
      (d.inMinutes -
              d.inDays * Duration.minutesPerDay -
              (d.inHours - d.inDays * Duration.hoursPerDay) *
                  Duration.minutesPerHour)
          .toString()
          .padLeft(2, '0') +
      'm:' +
      (d.inSeconds % 60).toString().padLeft(2, '0') +
      's';
}

class LaunchCountdown extends StatefulWidget {
  final SpacexHomeModel model;

  LaunchCountdown(this.model);
  State createState() => _LaunchCountdownState();
}

class _LaunchCountdownState extends State<LaunchCountdown>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.model.launch.launchDate.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch,
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      launchDate: widget.model.launch.launchDate,
      animation: StepTween(
        begin: widget.model.launch.launchDate.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch,
      ).animate(_controller),
    );
  }
}
