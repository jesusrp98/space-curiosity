import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../models/nasa/nasa_image.dart';
import '../nasa/screen.dart';
import 'cache_image.dart';
import 'separator.dart';

/// PHOTO CARD WIDGET
/// Widget used to display a NASA APOD photo.
class PhotoCard extends StatelessWidget {
  final NasaImage image;

  PhotoCard(this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NasaImagePage(image)),
            ),
        onLongPress: () async => await FlutterWebBrowser.openWebPage(
              url: image.url,
              androidToolbarColor: Theme.of(context).primaryColor,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Hero(tag: image.getDate, child: CacheImage(image.url)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: <Widget>[
                Text(
                  image.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Separator.spacer(height: 8),
                Text(
                  image.getDate,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
