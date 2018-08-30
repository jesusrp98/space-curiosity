import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_version/get_version.dart';
import 'package:space_news/screens/tabs/nasa/globals.dart' as globals;

// Stateful widget for managing name data
class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => new _HelpPageState();
}

// State for managing fetching name data over HTTP
class _HelpPageState extends State<HelpPage> {
  String _platformVersion = 'Unknown';
  String _projectVersion = 'Unknown';
  String _projectCode = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get platform version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
    });
  }

  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'version.securityPatch': build.version.securityPatch,
  //     'version.sdkInt': build.version.sdkInt,
  //     'version.release': build.version.release,
  //     'version.previewSdkInt': build.version.previewSdkInt,
  //     'version.incremental': build.version.incremental,
  //     'version.codename': build.version.codename,
  //     'version.baseOS': build.version.baseOS,
  //     'board': build.board,
  //     'bootloader': build.bootloader,
  //     'brand': build.brand,
  //     'device': build.device,
  //     'display': build.display,
  //     'fingerprint': build.fingerprint,
  //     'hardware': build.hardware,
  //     'host': build.host,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     'product': build.product,
  //     'supported32BitAbis': build.supported32BitAbis,
  //     'supported64BitAbis': build.supported64BitAbis,
  //     'supportedAbis': build.supportedAbis,
  //     'tags': build.tags,
  //     'type': build.type,
  //     'isPhysicalDevice': build.isPhysicalDevice,
  //   };
  // }

  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'name': data.name,
  //     'systemName': data.systemName,
  //     'systemVersion': data.systemVersion,
  //     'model': data.model,
  //     'localizedModel': data.localizedModel,
  //     'identifierForVendor': data.identifierForVendor,
  //     'isPhysicalDevice': data.isPhysicalDevice,
  //     'utsname.sysname:': data.utsname.sysname,
  //     'utsname.nodename:': data.utsname.nodename,
  //     'utsname.release:': data.utsname.release,
  //     'utsname.version:': data.utsname.version,
  //     'utsname.machine:': data.utsname.machine,
  //   };
  // }

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
                globals.Utility
                    .launchURL('https://www.github.com/appleeducate');
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
                globals.Utility.launchURL('https://www.twitter.com/rodydavis');
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
                globals.Utility.launchURL('https://www.facebook.com/rodydavis');
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
                globals.Utility.launchURL('https://www.rodydavis.com/apps');
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
                globals.Utility.launchURL('https://www.rodydavis.com/about');
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
                globals.Utility.launchURL('https://api.nasa.gov/');
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
