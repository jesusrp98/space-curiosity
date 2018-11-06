import 'dart:convert';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
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

  DateTime get launchDateTime => launch.launchDate;

  String get vehicle => 'Launched by ${launch.rocket.name}';

  String get payload {
    String aux = 'It will carry ';

    for (int i = 0; i < launch.rocket.secondStage.payloads.length; ++i)
      aux +=
          '${launch.rocket.secondStage.payloads[i].id} to ${launch.rocket.secondStage.payloads[i].orbit} orbit' +
              ((i + 1 == launch.rocket.secondStage.payloads.length)
                  ? '.'
                  : ', ');

    return aux;
  }

  String get launchDate => 'Launch is set to ${launch.getLaunchDate}.';

  String get launchpad => 'Launch will happend on ${launch.launchpadName}.';

  String get staticFire => (launch.staticFireDate == null)
      ? 'Static fire event is not dated yet.'
      : 'Static fire is dated to ${launch.getStaticFireDate}.';

  String get fairings =>
      'Fairings will' +
      ((launch.rocket.fairing.reused) ? ' ' : ' not ') +
      'be reused, and they ' +
      ((launch.rocket.fairing.recoveryAttempt)
          ? 'will be catched by ${launch.rocket.fairing.ship}.'
          : 'won\'t be recovered.');

  String get landings {
    String aux = '';
    List<String> cores = [
      'Booster',
      'Left core',
      'Right core',
    ];

    for (int i = 0; i < launch.rocket.firstStage.length; ++i)
      aux += '${cores[i]} is' +
          (launch.rocket.firstStage[i].reused ? ' ' : ' not ') +
          'reused, and it' +
          (launch.rocket.firstStage[i].landingIntent
              ? ' will perform a ${launch.rocket.firstStage[i].landingType} landing at ${launch.rocket.firstStage[i].landingZone}'
              : ' won\'t perform a landing') +
          ((i + 1 == launch.rocket.firstStage.length) ? '.' : '\n');

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
        seconds: widget.model.launchDateTime.millisecondsSinceEpoch -
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
      launchDate: widget.model.launchDateTime,
      animation: StepTween(
        begin: widget.model.launchDateTime.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch,
      ).animate(_controller),
    );
  }
}
