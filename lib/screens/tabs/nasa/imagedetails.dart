import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../models/daily_image.dart';
import '../../../widgets/hero_image.dart';

class ImageDetailsPage extends StatelessWidget {
  final ImageData image;
  ImageDetailsPage({this.image});

  @override
  Widget build(BuildContext context) {
    String content = image?.hdurl ?? image?.url ?? "";
    return new Scaffold(
        appBar: new AppBar(
          // backgroundColor: Colors.white,
          title: new Text(
            "Image Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              // action button
              icon: new Icon(Icons.share),
              onPressed: () {
                share(
                    'Nasa Image: ${image?.title},\n\nDescription: ${image?.description}\n\nImage: ${image?.hdurl}'); //True for Stock Camera
              },
            ),
          ],
        ),
        body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            new Text(
              image?.title,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            HeroImage().buildHero(
              size: 116.0,
              context: context,
              url: content,
              tag: image.id,
              title: image.title,
            ),
            new Text(
              image?.description,
              style: new TextStyle(fontSize: 14.0),
            ),
            new Text(
              image?.date,
              style: new TextStyle(fontSize: 10.0),
            ),
          ],
        ));
  }
}
