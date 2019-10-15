import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';

import '../../data/database/database.dart';
import '../general/cache_image.dart';
import '../general/sliver_bar.dart';

class NasaImagePage extends StatelessWidget {
  final NasaImage image;

  NasaImagePage(this.image);

  @override
  Widget build(BuildContext context) {
    //TODO revisar
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverBar(
            height: 0.4,
            header: InkWell(
              child: Hero(
                tag: image.url,
                child: CacheImage(image?.url),
              ),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                url: image.url,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    image?.title ?? 'No Title',
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                  Separator.spacer(space: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Row(children: <Widget>[
                          const Icon(Icons.copyright, size: 32),
                          Separator.spacer(space: 8),
                          Flexible(
                            child: Text(
                              image?.copyright ?? 'No Copyright',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                      ),
                            ),
                          )
                        ]),
                      ),
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  DateFormat.yMMMd().format(image.date) ??
                                      'No Date',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                      ),
                                ),
                              ),
                              Separator.spacer(space: 8),
                              const Icon(Icons.calendar_today, size: 32),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Separator.spacer(space: 16),
                  // TODO add text expander
                  Text(
                    image?.description ?? "",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color,
                      fontSize: 15,
                    ),
                  ),
                  Separator.thickDivider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OptionButton(
                        icon: Icons.share,
                        title: FlutterI18n.translate(context, 'nasa.share'),
                        onTap: () => Share.share(image.url),
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

class HeaderDetails extends StatelessWidget {
  final IconData icon;
  final String title;

  HeaderDetails({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(children: <Widget>[
        Icon(
          icon,
          size: 27,
          color: Theme.of(context).textTheme.caption.color,
        ),
        Separator.spacer(space: 8),
        Text(
          title ?? 'No Title',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: Theme.of(context).textTheme.caption.color,
              ),
        ),
      ]),
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
    return Expanded(
      flex: 1,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 32),
              Separator.spacer(space: 8),
              Flexible(
                child: Center(
                  child: Text(
                    title ?? 'No Title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Theme.of(context).textTheme.caption.color),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
