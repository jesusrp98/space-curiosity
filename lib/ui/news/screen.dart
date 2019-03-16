import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;

import '../../data/bloc/bloc.dart';
import '../../data/models/models.dart';
import '../../util/menu.dart';
import '../general/hero_image.dart';
import '../general/list_cell.dart';
import '../general/loading_indicator.dart';
import '../general/separator.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final PostBloc _postBloc = PostBloc(http.Client());

  _ArticlesScreenState() {
    _postBloc.dispatch(Fetch());
  }

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
      body: BlocBuilder(
        bloc: _postBloc,
        builder: (context, state) {
          if (state is PostUninitialized) {
            return LoadingIndicator();
          }
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return ListView.separated(
              itemCount: state.posts.length,
              itemBuilder: (_, index) {
                final Post post = state.posts[index];
                return Column(
                  children: <Widget>[
                    ListCell(
                      leading: ClipRRect(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(8)),
                        child: HeroImage(
                          url: post.photo,
                          tag: index.toString(),
                          size: 64.0,
                        ),
                      ),
                      title: post.getTitle,
                      subtitle: post.author,
                      maxTitleLines: 2,
                      onTap: () async => await FlutterWebBrowser.openWebPage(
                            url: post.url,
                            androidToolbarColor: Theme.of(context).primaryColor,
                          ),
                    ),
                    state.posts.last == post
                        ? Column(children: <Widget>[
                            Separator.divider(height: 16),
                            Text(
                              FlutterI18n.translate(context, 'news.credits'),
                              style:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                      ),
                            ),
                            Separator.spacer(height: 16),
                          ])
                        : Separator.none()
                  ],
                );
              },
              separatorBuilder: (_, index) =>
                  Separator.divider(height: 0, indent: 96),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }
}
