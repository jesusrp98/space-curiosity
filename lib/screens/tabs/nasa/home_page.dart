import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/daily_image.dart';
import '../../../util/axis_count.dart';
import '../../../util/open_url.dart';
import 'help.dart';
import 'imagedetails.dart';

class NasaTab extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Null> _onRefresh(NasaImagesModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NasaImagesModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage()),
                      ),
                ),
              ],
              title: const Text(
                "Daily NASA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => _onRefresh(model),
                child: StreamBuilder(
                  stream: model.fetchImages().asStream().distinct(),
                  builder: (BuildContext context, _) {
                    if (model.images == null)
                      return NativeLoadingIndicator(
                        center: true,
                        text: Text("Loading..."),
                      );

                    if (model.images.isEmpty)
                      return Center(child: Text("No Images Found"));
                    int axisCount = getAxisCount(context);

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: axisCount),
                      itemCount: model.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        model.fetchMore();
                        String content = model.images[index]?.hdurl ??
                            model.images[index]?.url ??
                            "";

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
                          onLongPress: () => openURL(content),
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
                                child: Image.network(content),
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
