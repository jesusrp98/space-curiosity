import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageDetailsPage extends StatelessWidget {
  final String title, imageUrl, hdImageUrl, dateCreated, description;
  ImageDetailsPage(
      {this.description,
      this.dateCreated,
      this.hdImageUrl,
      this.imageUrl,
      this.title});

  Future openImage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String content =
        hdImageUrl == null ? imageUrl == null ? "" : imageUrl : hdImageUrl;
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
                    'Nasa Image: $title,\n\nDescription: $description\n\nImage: $hdImageUrl'); //True for Stock Camera
              },
            ),
          ],
        ),
        body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            new Text(
              title,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            new InkWell(
              onTap: () {
                openImage(content);
              },
              child: content.isEmpty || content == null
                  ? new Center(
                      child: new Icon(
                        Icons.broken_image,
                        size: 100.0,
                      ),
                    )
                  : content.contains('youtube') || content.contains('vimeo')
                      ? new Center(
                          child: new Icon(
                            Icons.ondemand_video,
                            size: 100.0,
                          ),
                        )
                      : new Image.network(
                          content,
                        ),
            ),
            new Text(
              description,
              style: new TextStyle(fontSize: 14.0),
            ),
            new Text(
              dateCreated,
              style: new TextStyle(fontSize: 10.0),
            ),
          ],
        ));
  }
}
