import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_version/get_version.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => new _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String _platformVersion = 'Unknown';
  String _projectVersion = 'Unknown';
  String _projectCode = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }


  initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get platform version.';
    }

    String projectCode;
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
    });
  }

  Future openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // backgroundColor: Colors.white,
        title: new Text(
          "Info",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Container(
              height: 10.0,
            ),
            new ListTile(
              leading: new Icon(FontAwesomeIcons.github),
              title: const Text('Github'),
              subtitle: new Text('@AppleEducate'),
              onTap: () {
                openLink('https://www.github.com/appleeducate');
              },
            ),
            new Divider(
              height: 20.0,
            ),
            new ListTile(
              leading: new Icon(FontAwesomeIcons.twitter),
              title: const Text('Twitter'),
              subtitle: new Text('@RodyDavis'),
              onTap: () {
               openLink('https://www.twitter.com/rodydavis');
              },
            ),
            new Divider(
              height: 20.0,
            ),
            new ListTile(
              leading: new Icon(FontAwesomeIcons.facebook),
              title: const Text('Facebook'),
              subtitle: new Text('@RodyDavis'),
              onTap: () {
                openLink('https://www.facebook.com/rodydavis');
              },
            ),
            new Divider(
              height: 20.0,
            ),
            new ListTile(
              leading: new Icon(Icons.apps),
              title: const Text('Apps'),
              subtitle: new Text('by Rody Davis'),
              onTap: () {
                openLink('https://www.rodydavis.com/apps');
              },
            ),
            new Divider(
              height: 20.0,
            ),
            new ListTile(
              leading: new Icon(Icons.contact_mail),
              title: const Text('Contact'),
              subtitle: new Text('Submit Issues and Questions'),
              onTap: () {
                openLink('https://www.rodydavis.com/about');
              },
            ),
            new Divider(
              height: 20.0,
            ),
            new ListTile(
              leading: new Icon(FontAwesomeIcons.spaceShuttle),
              title: const Text('NASA'),
              subtitle: new Text('All Images provided by API'),
              onTap: () {
                openLink('https://api.nasa.gov/');
              },
            ),
            new Divider(
              height: 20.0,
            ),
            new ListTile(
              leading: new Icon(Icons.info),
              title: const Text('Version'),
              subtitle: new Text('$_projectVersion ($_projectCode)'),
              trailing: new Text('$_platformVersion'),
            ),
          ],
        ),
      ),
    );
  }
}
