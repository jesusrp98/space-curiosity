import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;
import 'package:row_collection/row_collection.dart';

import '../../data/bloc/bloc.dart';
import '../../data/models/models.dart';
import '../general/hero_image.dart';
import '../general/list_cell.dart';

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
        title: Text('Latest news'),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: _postBloc,
        builder: (context, state) {
          if (state is PostUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
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
                return ListCell(
                  leading: HeroImage.list(
                    url: post.photo,
                    tag: index.toString(),
                  ),
                  title: post.getTitle,
                  subtitle: post.author,
                  onTap: () async => await FlutterWebBrowser.openWebPage(
                        url: post.url,
                        androidToolbarColor: Theme.of(context).primaryColor,
                      ),
                );
              },
              separatorBuilder: (_, index) => Separator.divider(indent: 96),
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
