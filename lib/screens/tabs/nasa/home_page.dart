import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:space_news/screens/tabs/nasa/globals.dart' as globals;

import 'help.dart';
import 'imagedetails.dart';
// import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';
const String iosAdmobAppID = "ca-app-pub-7837488287280985~4079769179";
const String androidAdmobAppID = "ca-app-pub-7837488287280985~7248645342";
const String iosBannerAd = 'ca-app-pub-7837488287280985/3391651263';
const String iosFullAd = 'ca-app-pub-7837488287280985/9162852696';
const String androidBannerAd = 'ca-app-pub-7837488287280985/3718954322';
const String androidFullAd = 'ca-app-pub-7837488287280985/8396565931';

class NasaHomePage extends StatefulWidget {
  @override
  _NasaHomePageState createState() => new _NasaHomePageState();
}

class _NasaHomePageState extends State<NasaHomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List data;
  String apiKey = "ecbPd1gAXph1ytyKAEUeu7KRB5xGEx5XOkB7Xoi4";
  int count = 100;
  bool _reverse = false;
  bool isLoaded = false;
  bool isDebug = false;
  int hitCount = 0;

  Future getData() async {
    isLoaded = false;
    String result = "";
    result = "" +
        await globals.Utility.getData('https://api.nasa.gov/planetary/apod?',
            'api_key=$apiKey&count=$count');
    // print('Result: $result');
    if (result.contains('Error')) {
      result = "" +
          await globals.Utility.getData('https://api.nasa.gov/planetary/apod?',
              'api_key=$apiKey&count=$count');
      if (result.contains('Error')) {
        result = "" +
            await globals.Utility.getData(
                'https://api.nasa.gov/planetary/apod?',
                'api_key=$apiKey&count=$count');
      }
    }
    try {
      if (result.contains('Error')) {
        // _scaffoldKey.currentState.showSnackBar(new SnackBar(
        //     content: new Text(
        //         'Failed fetching images, please refresh and try again.')));
        globals.Utility.showAlertPopup(context, 'Info',
            'Failed fetching images.\nPlease refresh and try again.');
      } else {
        List decoded = json.decode(result);
        for (var row in decoded) {
          addNewItem(row);
        }
        data = decoded;
      }
    } catch (ex) {
      print(ex);
    }
    showBanner();
    isLoaded = true;
    firstBottom = true;
  }

  void addNewItem(Map row) {
    String content = row["hdurl"] == null
        ? row["url"] == null ? "" : row["url"]
        : row["hdurl"];
    _items.add(
      new InkWell(
        onLongPress: () {
          String image = row["hdurl"] == null ? row["url"] : row["hdurl"];
          globals.Utility.launchURL(image);
        },
        onTap: () {
          showFullAd();
          globals.title = row["title"];
          globals.datecreated = row["date"];
          globals.imageurl = row["url"];
          globals.hdimageurl = row["hdurl"];
          globals.description = row["explanation"];
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ImageDetailsPage(),
                maintainState: true),
          );
        },
        child: new Card(
          elevation: 1.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new Center(
                  child: new Text(
                row["title"],
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                textAlign: TextAlign.center,
              )),
              new Expanded(
                child: content.contains('youtube') || content.contains('vimeo')
                    ? new Center(
                        child: new Icon(
                          Icons.ondemand_video,
                          size: 60.0,
                        ),
                      )
                    : content.toString().isEmpty || content == null
                        ? new Center(
                            child: new Icon(
                              Icons.broken_image,
                              size: 60.0,
                            ),
                          )
                        : new Image.network(
                            content,
                            height: 65.0,
                            width: 65.0,
                            fit: BoxFit.fitHeight,
                          ),
              ),
              new Container(
                height: 10.0,
              ),
              new Center(
                  child: new Text(
                row["date"],
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _items = new List.generate(0, (index) {
    return new Text("item $index");
  });

  // static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  //   // testDevices: testDevice != null ? <String>[testDevice] : null,
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   birthday: new DateTime.now(),
  //   childDirected: true,
  //   gender: MobileAdGender.male,
  // );

  // BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;

  // BannerAd createBannerAd() {
  //   return new BannerAd(
  //     adUnitId: isDebug
  //         ? BannerAd.testAdUnitId
  //         : Platform.isIOS ? iosBannerAd : androidBannerAd,
  //     size: AdSize.banner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event $event");
  //     },
  //   );
  // }

  // InterstitialAd createInterstitialAd() {
  //   return new InterstitialAd(
  //     adUnitId: isDebug
  //         ? InterstitialAd.testAdUnitId
  //         : Platform.isIOS ? iosFullAd : androidFullAd,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("InterstitialAd event $event");
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(
    //     appId: isDebug
    //         ? FirebaseAdMob.testAppId
    //         : Platform.isIOS ? iosAdmobAppID : androidAdmobAppID);
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();
    // _interstitialAd = createInterstitialAd()..load();

    getData().then((result) {
      setState(() {
        print('Data Loaded');
        // data = newData;
        // _bannerAd ??= createBannerAd();
        // _bannerAd
        //   ..load()
        //   ..show();
      });
    });
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    // _interstitialAd?.dispose();
    super.dispose();
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();

    _items.clear();
    getData().then((result) {
      setState(() {
        print('Data Loaded');
        // data = newData;
        // showInterstitialAd();
      });
    });
    completer.complete();

    return completer.future;
  }

  void showBanner() {
    print('New Banner Shown');
    // _bannerAd?.dispose();
    // _bannerAd = null;

    // _bannerAd ??= createBannerAd();
    // _bannerAd
    //   ..load()
    //   ..show();
  }

  void showFullAd() {
    if (hitCount.isEven) {
      print('New Full Screen Ad Shown');
      // _interstitialAd?.dispose();
      // _interstitialAd = createInterstitialAd()
      //   ..load()
      //   ..show();
    }
    print("Hits: $hitCount");
    hitCount++;
  }

  void goToAbout() {
    // _bannerAd?.dispose();
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new HelpPage()),
    );
  }

  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  bool firstBottom = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int axisCount =
        width <= 500.0 ? 2 : width <= 800.0 ? 3 : width <= 1100.0 ? 4 : 5;
    Widget _list = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: _items.length == 0 && !isLoaded
          ? new Align(
              child: new CircularProgressIndicator(),
              alignment: FractionalOffset.center,
            )
          : _items.length == 0 && isLoaded
              ? new Center(
                  child: new Text('No Images Found'),
                )
              : new GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisCount),
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _items == null ? 0 : _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print('Index: $index => Count: $count');
                    if (index == count - 1 && firstBottom == true) {
                      // _loadMoreItems();
                      firstBottom = false;
                      showFullAd();
                    }
                    return _items[index];
                  },
                  reverse: _reverse,
                ),
    );
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        // backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.info),
            onPressed: goToAbout,
          ),
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              _refreshIndicatorKey.currentState?.show();
              _onRefresh();
            },
          ),
        ],
        title: const Text(
          "Daily NASA",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _list,
    );
  }
}
