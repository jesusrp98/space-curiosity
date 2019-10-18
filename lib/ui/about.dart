import 'dart:io';
import 'dart:math';

import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:space_news/plugins/url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:row_collection/row_collection.dart';

import '../util/url.dart';
import 'general/dialog_round.dart';
import 'general/list_cell.dart';

/// ABOUT SCREEN
/// This view contains a list with useful
/// information about the app & its developers.
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  static final List<Map<String, String>> _translators = [
    {'name': 'Jesús Rodríguez', 'language': 'English'},
    {'name': 'Jesús Rodríguez', 'language': 'Español'},
  ];

  static final List<Map<String, String>> _credits = [
    {'title': 'r/SpaceX API', 'body': 'Open-source SpaceX API'},
    {'title': 'NASA APOD', 'body': 'Astronomical Picture Of the Day'},
    {'title': 'Open Notify', 'body': 'Open APIs From Space'},
  ];

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  initState() {
    super.initState();
    _initPackageInfo();
    if (Platform.isIOS) AppReview.requestReview;
  }

  Future<Null> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    //TODO revisar
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'home.menu.about',
        )),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        ListCell(
          leading: const Icon(Icons.info_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.version.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.version.body',
            {'version': _packageInfo.version, 'status': 'release'},
          ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.person_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.author.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.author.body',
          ),
          onTap: () async => await UrlUtils.open(
                url: Url.authorsReddit[Random().nextInt(2)],
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.star_border, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.review.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.review.body',
          ),
          onTap: () => AppReview.storeListing,
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.mail_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.email.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.email.body',
          ),
          onTap: () async => await FlutterMailer.send(MailOptions(
                subject: Url.email['subject'],
                recipients: [Url.email['address']],
              )),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.apps, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.more_apps.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.more_apps.body',
          ),
          onTap: () async => await UrlUtils.open(
                url: Url.authorsStore[Platform.isIOS ? 0 : 1],
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.public, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.translations.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.translations.body',
          ),
          onTap: () => showDialog(
                context: context,
                builder: (context) => RoundDialog(
                      title: FlutterI18n.translate(
                        context,
                        'about.translations.title',
                      ),
                      children: _translators
                          .map((translation) => ListCell(
                                title: translation['name'],
                                subtitle: translation['language'],
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 24,
                                ),
                              ))
                          .toList(),
                    ),
              ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.people_outline, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.free_software.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.free_software.body',
          ),
          onTap: () async => await UrlUtils.open(
                url: Url.githubPage,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.code, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.flutter.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.flutter.body',
          ),
          onTap: () async => await UrlUtils.open(
                url: Url.flutterPage,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.folder_open, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.credits.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.credits.body',
          ),
          onTap: () => showDialog(
                context: context,
                builder: (context) => RoundDialog(
                      title: FlutterI18n.translate(
                        context,
                        'about.credits.title',
                      ),
                      children: _credits
                          .map((translation) => ListCell(
                                title: translation['title'],
                                subtitle: translation['body'],
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 24,
                                ),
                              ))
                          .toList(),
                    ),
              ),
        ),
        Separator.divider(indent: 72),
        ListCell(
          leading: const Icon(Icons.copyright, size: 40),
          title: FlutterI18n.translate(
            context,
            'about.copyright.title',
          ),
          subtitle: FlutterI18n.translate(
            context,
            'about.copyright.body',
          ),
        ),
        Separator.divider(indent: 72),
      ]),
    );
  }
}
