import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:image_downloader/image_downloader.dart';
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
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
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
                  Text(
                    image.title,
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                  Container(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.copyright, size: 32.0),
                          Container(width: 8.0),
                          Text(
                            image.getCopyright(context),
                            style: Theme.of(context)
                                .textTheme
                                .subhead
                                .copyWith(color: secondaryText),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            image.getDate,
                            style: Theme.of(context)
                                .textTheme
                                .subhead
                                .copyWith(color: secondaryText),
                          ),
                          Container(width: 8.0),
                          Icon(Icons.calendar_today, size: 32.0),
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
                  Divider(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OptionButton(
                        icon: Icons.share,
                        title: FlutterI18n.translate(context, 'nasa.share'),
                        onTap: () => share(image.share(context)),
                      ),
                      OptionButton(
                        icon: Icons.link,
                        title: FlutterI18n.translate(context, 'nasa.copy_link'),
                        onTap: () => ClipboardManager.copyToClipBoard(
                              image.url,
                            ),
                      ),
                      OptionButton(
                        icon: Icons.get_app,
                        title: FlutterI18n.translate(context, 'nasa.download'),
                        onTap: () => ImageDownloader.downloadImage(image.url),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  OptionButton({this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 32.0),
            Container(width: 8.0),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: secondaryText),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
