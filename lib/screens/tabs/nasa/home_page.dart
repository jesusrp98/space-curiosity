import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'help.dart';
import 'imagedetails.dart';
// import 'package:space_news/screens/tabs/nasa/globals.dart' as globals;

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
  _NasaHomePageState createState() => _NasaHomePageState();
}

class _NasaHomePageState extends State<NasaHomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List data;
  String apiKey = "ecbPd1gAXph1ytyKAEUeu7KRB5xGEx5XOkB7Xoi4";
  int count = 100;
  bool _reverse = false;
  bool isLoaded = false;
  bool isDebug = false;
  int hitCount = 0;

  Future<String> getData(String api, String headers) async {
    var requestURL = api;
    requestURL = requestURL + headers;
    print("Request URL: " + requestURL);

    var url = requestURL;
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        try {
          var json = await response.transform(utf8.decoder).join();
          result = json;
        } catch (exception) {
          result = 'Error Getting Data';
        }
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address $exception';
    }
    print("Result: " + result);
    return result;
  }

  Future _getData() async {
    isLoaded = false;
    String result = "";
    result = "" +
        await getData('https://api.nasa.gov/planetary/apod?',
            'api_key=$apiKey&count=$count');
    // print('Result: $result');
    if (result.contains('Error')) {
      result = "" +
          await getData('https://api.nasa.gov/planetary/apod?',
              'api_key=$apiKey&count=$count');
      if (result.contains('Error')) {
        result = "" +
            await getData('https://api.nasa.gov/planetary/apod?',
                'api_key=$apiKey&count=$count');
      }
    }
    try {
      if (result.contains('Error')) {
        // _scaffoldKey.currentState.showSnackBar(new SnackBar(
        //     content:Text(
        //         'Failed fetching images, please refresh and try again.')));
        showAlertPopup(context, 'Info',
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

  Future openImage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void addNewItem(Map row) {
    String content = row["hdurl"] ?? row["url"] ?? "";
    _items.add(
      InkWell(
        onLongPress: () {
          String image = row["hdurl"] ?? row["url"];
          openImage(image);
        },
        onTap: () {
          showFullAd();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDetailsPage(
                    title: row["title"],
                    dateCreated: row["date"],
                    imageUrl: row["url"],
                    hdImageUrl: row["hdurl"],
                    description: row["explanation"],
                  ),
              maintainState: true,
            ),
          );
        },
        child: Card(
          elevation: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Center(
                  child: Text(
                row["title"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: content.contains('youtube') || content.contains('vimeo')
                    ? Center(
                        child: Icon(
                          Icons.ondemand_video,
                          size: 60.0,
                        ),
                      )
                    : content.toString().isEmpty || content == null
                        ? Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 60.0,
                            ),
                          )
                        : Image.network(
                            content,
                            height: 65.0,
                            width: 65.0,
                            fit: BoxFit.fitHeight,
                          ),
              ),
              Container(
                height: 10.0,
              ),
              Center(
                  child: Text(
                row["date"],
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _items = List.generate(0, (index) {
    return Text("item $index");
  });

  // static final MobileAdTargetingInfo targetingInfo =MobileAdTargetingInfo(
  //   // testDevices: testDevice != null ? <String>[testDevice] : null,
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   birthday:DateTime.now(),
  //   childDirected: true,
  //   gender: MobileAdGender.male,
  // );

  // BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;

  // BannerAd createBannerAd() {
  //   returnBannerAd(
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
  //   returnInterstitialAd(
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

    _getData().then((result) {
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
    Completer<Null> completer = Completer<Null>();

    _items.clear();
    _getData().then((result) {
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
      MaterialPageRoute(builder: (context) => HelpPage()),
    );
  }

  Future<Null> delay(int milliseconds) {
    return Future.delayed(new Duration(milliseconds: milliseconds));
  }

  bool firstBottom = true;

  void showAlertPopup(BuildContext context, String title, String detail) async {
    void showDemoDialog<T>({BuildContext context, Widget child}) {
      showDialog<T>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => child,
      );
    }

    return showDemoDialog<Null>(
        context: context,
        child: NativeDialog(
          title: title,
          content: detail,
          actions: <NativeDialogAction>[
            NativeDialogAction(
                text: 'OK',
                isDestructive: false,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int axisCount =
        width <= 500.0 ? 2 : width <= 800.0 ? 3 : width <= 1100.0 ? 4 : 5;
    Widget _list = RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: _items.length == 0 && !isLoaded
          ? Align(
              child: CircularProgressIndicator(),
              alignment: FractionalOffset.center,
            )
          : _items.length == 0 && isLoaded
              ? Center(
                  child: Text('No Images Found'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: goToAbout,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
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
