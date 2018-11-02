import 'dart:convert';

import 'package:duration/duration.dart';
import 'package:http/http.dart' as http;

import '../../util/url.dart';
import '../querry_model.dart';
import 'launch.dart';

class SpacexHomeModel extends QuerryModel {
  Launch launch;

  @override
  Future loadData() async {
    final response = await http.get(Url.nextLaunch);
    clearLists();

    photos.addAll(Url.spacexHomeScreen);
    launch = Launch.fromJson(json.decode(response.body));

    loadingState(false);
  }

  String get countdown =>
      'T - ${printDuration(launch.launchDate.difference(DateTime.now()), abbreviated: true, delimiter: ' : ', spacer: '')}';

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
      'Central booster',
      'Left booster',
      'Right booster',
    ];

    for (int i = 0; i < launch.rocket.firstStage.length; ++i)
      aux += '${cores[i]}' +
          (!launch.rocket.firstStage[i].reused ? ' ' : ' not ') +
          'reused, and it' +
          (launch.rocket.firstStage[i].landingIntent
              ? ' will perform a ${launch.rocket.firstStage[i].landingType} landing at ${launch.rocket.firstStage[i].landingZone}'
              : ' won\'t perform a landing') +
          ((i + 1 == launch.rocket.firstStage.length) ? '.' : '\n');

    return aux;
  }
}
