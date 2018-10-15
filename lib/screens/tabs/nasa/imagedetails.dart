import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:share/share.dart';

import '../../../models/nasa/nasa_image.dart';
import '../../../util/colors.dart';
import 'screen_more_nasa.dart';

class ImageDetailsPage extends StatelessWidget {
  final NasaImage image;
  ImageDetailsPage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // App bar extends 0.4 times the screen height
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            floating: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => share(image.share),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(image.title),
              background: InkWell(
                child: Hero(
                  tag: image.getDate,
                  child: Image.network(image.url, fit: BoxFit.cover),
                ),
                onTap: () => () async => await FlutterWebBrowser.openWebPage(
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
                      Text(
                        image.getCopyright,
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        image.getDate,
                        style: Theme.of(context).textTheme.body1,
                      ),
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
        child: const Icon(Icons.more),
        tooltip: 'More images',
        onPressed: () => NasaMoreImages(),
      ),
    );
  }
}
