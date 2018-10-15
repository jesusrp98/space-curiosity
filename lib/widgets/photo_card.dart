import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../models/nasa/nasa_image.dart';
import '../screens/tabs/nasa/imagedetails.dart';
import '../util/colors.dart';

class PhotoCard extends StatelessWidget {
  final NasaImage image;

  PhotoCard(this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageDetailsPage(image),
              ),
            ),
        onLongPress: () async => await FlutterWebBrowser.openWebPage(
              url: image.url,
              androidToolbarColor: primaryColor,
            ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: image.getDate,
                child: Image.network(
                  image.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    image.title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(height: 8.0),
                  Text(image.getDate, style: Theme.of(context).textTheme.title),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhotoCardCompact extends StatelessWidget {
  final NasaImage image;

  PhotoCardCompact(this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageDetailsPage(image),
              ),
            ),
        onLongPress: () async => await FlutterWebBrowser.openWebPage(
              url: image.url,
              androidToolbarColor: primaryColor,
            ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: image.getDate,
                child: Image.network(
                  image.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    image.title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(height: 8.0),
                  Text(image.getDate, style: Theme.of(context).textTheme.title),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
