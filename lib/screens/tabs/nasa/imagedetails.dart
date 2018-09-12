import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/daily_image.dart';
import '../../../util/sendSMS.dart';

class ImageDetailsPage extends StatelessWidget {
  final ImageData image;
  final String currentImage;
  ImageDetailsPage({this.image, this.currentImage});

  Future openImage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String newLine = "\n\n";
    String _message = "" +
        '${image?.title}' +
        newLine +
        '{image?.description}' +
        newLine +
        '${image?.hdurl}';
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Image Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.message),
            onPressed: () => sendSMS(_message, []),
          ),
          new IconButton(
            icon: new Icon(Icons.share),
            onPressed: () => share(_message),
          ),
        ],
        centerTitle: true,
      ),
      body: new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          new Text(
            image?.title,
            style: Theme.of(context).textTheme.display1,
          ),
          Container(height: 4.0),
          InkWell(
            child: Hero(
              tag: image.id,
              child: Image.network(currentImage),
            ),
            onTap: () => openImage(currentImage),
          ),
          Container(height: 4.0),
          new Text(
            image?.description,
            style: Theme.of(context).textTheme.body1,
          ),
          Container(height: 4.0),
          new Text(
            image?.date,
            style: new TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
