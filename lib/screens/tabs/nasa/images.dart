import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/daily_image.dart';
import '../../../widgets/cached_image.dart';
import 'help.dart';
import 'imagedetails.dart';

class NasaHomePage extends StatefulWidget {
  @override
  _NasaHomePageState createState() => _NasaHomePageState();
}

class _NasaHomePageState extends State<NasaHomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int count = 100;

  Future openImage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> _onRefresh(NasaImages model) {
    Completer<Null> completer = Completer<Null>();
    model.fetchImages(count).then((_) => completer.complete());
    return completer.future;
  }

  void goToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpPage()),
    );
  }

  Future<Null> delay(int milliseconds) {
    return Future.delayed(new Duration(milliseconds: milliseconds));
  }

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
    return new ScopedModel<NasaImages>(
      model: NasaImages(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              onPressed: goToAbout,
            ),
          ],
          title: const Text(
            "Daily NASA",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<NasaImages>(
          builder: (context, child, model) => RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => _onRefresh(model),
                child: StreamBuilder(
                  stream: model.fetchImages(count).asStream(),
                  builder: (BuildContext context, _) {
                    if (model.images == null)
                      return NativeLoadingIndicator(
                        center: true,
                        text: Text("Loading..."),
                      );

                    if (model.images.isEmpty)
                      return Center(child: Text("No Images Found"));

                    double width = MediaQuery.of(context).size.width;
                    int axisCount = width <= 500.0
                        ? 2
                        : width <= 800.0 ? 3 : width <= 1100.0 ? 4 : 5;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: axisCount),
                      itemCount: model.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == count - 1) {
                          count += 100;
                          model.fetchImages(count);
                        }

                        String content = model.images[index]?.hdurl ??
                            model.images[index]?.url ??
                            "";
                        var _currentImage = getImagePreview(content);
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return ImageDetailsPage(
                                image: model.images[index],
                                currentImage: content,
                              );
                            }));
                          },
                          onLongPress: () => openImage(content),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: GridTile(
                              header: Text(
                                model.images[index]?.title ?? "",
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                              child: Hero(
                                tag: model.images[index].id,
                                child: _currentImage,
                              ),
                              footer: Text(
                                model.images[index]?.date ?? "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
        ),
      ),
    );
  }
}
