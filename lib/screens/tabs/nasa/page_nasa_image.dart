import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:share/share.dart';

import '../../../models/nasa/nasa_image.dart';
import '../../../util/colors.dart';

class NasaImagePage extends StatelessWidget {
  final NasaImage image;
  NasaImagePage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(image.title),
              background: InkWell(
                child: Hero(
                  tag: image.getDate,
                  child: CachedNetworkImage(
                    imageUrl: image.url,
                    errorWidget: const Icon(Icons.error),
                    fadeInDuration: Duration(milliseconds: 100),
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () => FlutterWebBrowser.openWebPage(
                      url: image.hdurl,
                      androidToolbarColor: primaryColor,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.copyright, size: 42.0),
                          Text(
                            image.getCopyright,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.calendar_today, size: 42.0),
                          Text(
                            image.getDate,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(height: 16.0),
                  Text(
                    image.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: secondaryText),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        tooltip: 'Share',
        onPressed: () => share(image.share),
      ),
    );
  }
}
