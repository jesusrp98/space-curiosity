import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async_resource/file_resource.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/daily_image.dart';
import '../../../util/cache_settings.dart';
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

  String apiKey = "ecbPd1gAXph1ytyKAEUeu7KRB5xGEx5XOkB7Xoi4";
  int count = 100;
  bool _reverse = false;
  bool isLoaded = false;
  bool isDebug = false;
  int hitCount = 0;
  List<ImageData> images;

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
      if (response.statusCode == HttpStatus.ok) {
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

  Future<List<ImageData>> _getData() async {
    isLoaded = false;
    List<ImageData> _data;
    try {
      String _url = 'https://api.nasa.gov/planetary/apod?'
          'api_key=$apiKey&count=$count';
      final path = (await getApplicationDocumentsDirectory()).path;
      final myDataResource = HttpNetworkResource<List<ImageData>>(
        url: _url,
        parser: (contents) {
          List decoded = json.decode(contents.toString());
          _data = [];
          for (Map row in decoded) _data.add(ImageData.fromJson(row));
          return _data;
        },
        cache: FileResource(File('$path/nasa_images.json')),
        maxAge: cacheDuration,
        strategy: cacheStrategy,
      );
      _data = await myDataResource.get();
    } catch (e) {
      print("Error Cached DailyImage: $e");
    }
    try {
      if (_data == null) {
        String _response = await getData('https://api.nasa.gov/planetary/apod?',
            'api_key=$apiKey&count=$count');
        List decoded = json.decode(_response);
        _data = [];
        for (Map row in decoded) _data.add(ImageData.fromJson(row));
      }
    } catch (e) {
      print('Error Creating DailyImage: $e');
    }

    showBanner();
    isLoaded = true;
    firstBottom = true;

    return _data;
  }

  Future openImage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        images = result;
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

    _getData().then((result) {
      setState(() {
        images = result;
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

  Widget _buildItem(BuildContext context, int index) {
    if (index == count - 1 && firstBottom == true) {
      // _loadMoreItems();
      firstBottom = false;
      showFullAd();
    }

    String content = images[index]?.hdurl ?? images[index]?.url ?? "";
    return InkWell(
      onLongPress: () {
        openImage(content);
      },
      onTap: () {
        showFullAd();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailsPage(
                  title: images[index]?.title ?? "No Name Found",
                  dateCreated: images[index]?.date ?? "No Date Found",
                  imageUrl: images[index]?.url ?? "",
                  hdImageUrl: images[index]?.hdurl ?? "",
                  description: images[index]?.description ?? "",
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
              images[index]?.title ?? "",
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
              images[index]?.date ?? "",
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (images == null) {
      return NativeLoadingIndicator(text: Text('Loading...'));
    }

    if (images.isEmpty) {
      return Center(
        child: Text('No Images Found'),
      );
    }
    double width = MediaQuery.of(context).size.width;
    int axisCount =
        width <= 500.0 ? 2 : width <= 800.0 ? 3 : width <= 1100.0 ? 4 : 5;
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: axisCount),
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: images.length,
      itemBuilder: _buildItem,
      reverse: _reverse,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: _buildList(context),
      ),
    );
  }
}
