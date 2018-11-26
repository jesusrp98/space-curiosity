import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../models/nasa/nasa_image.dart';
import '../screens/tabs/nasa/page_nasa_image.dart';
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
                builder: (_) => NasaImagePage(image),
              ),
            ),
        onLongPress: () => FlutterWebBrowser.openWebPage(
              url: image.url,
              androidToolbarColor: primaryColor,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: image.getDate,
                child: getMedia(image.url),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    image.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(height: 8.0),
                  Text(
                    image.getDate,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: secondaryText),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMedia(String url) {
    return CachedNetworkImage(
            imageUrl: url.contains('youtube') ? getVideoThumbnail(url) : url,
            errorWidget: const Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 100),
            fit: BoxFit.cover,
          );
  }

  String getVideoThumbnail(String url) {
    RegExp regExp = RegExp(r"");

    return regExp.stringMatch(url).toString();
  }
}
