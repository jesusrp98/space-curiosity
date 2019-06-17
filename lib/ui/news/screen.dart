import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/models.dart';
import '../../util/menu.dart';
import '../general/hero_image.dart';
import '../general/list_cell.dart';

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'home.page.menu.news')),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (_) => Menu.news.keys
                .map((url) => PopupMenuItem(
                      value: url,
                      child: Text(FlutterI18n.translate(
                        context,
                        url,
                      )),
                    ))
                .toList(),
            onSelected: (name) async => await FlutterWebBrowser.openWebPage(
                  url: Menu.news[name],
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
      body: Consumer<NewsModel>(
        builder: (context, model, child) {
          if (model.isLoading) {
            return CircularProgressIndicator();
          }
          if (model.isError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }

          if (model?.posts == null || model.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.separated(
            itemCount: model.posts.length,
            itemBuilder: (_, index) {
              final Post post = model.posts[index];
              return Column(
                children: <Widget>[
                  ListCell(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(8),
                      ),
                      child: HeroImage(
                        url: post.photo,
                        tag: index.toString(),
                        size: 64.0,
                      ),
                    ),
                    title: post.getTitle,
                    subtitle: post.author,
                    onTap: () async => await FlutterWebBrowser.openWebPage(
                          url: post.url,
                          androidToolbarColor: Theme.of(context).primaryColor,
                        ),
                  ),
                  model.posts.last == post
                      ? Column(children: <Widget>[
                          Separator.divider(),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              FlutterI18n.translate(context, 'news.credits'),
                              style:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                      ),
                            ),
                          ),
                        ])
                      : Separator.none()
                ],
              );
            },
            separatorBuilder: (_, index) => Separator.divider(indent: 96),
          );
        },
      ),
    );
  }
}
