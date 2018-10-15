import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:native_widgets/native_widgets.dart';
import 'package:webfeed/webfeed.dart';

class NewsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Breaking News'),
        centerTitle: true,
      ),
      body: NewsList(),
    );
  }
}

class NewsList extends StatelessWidget {
  Future<RssFeed> getFeed() async {
    var client = new http.Client();
    // RSS feed
    var response =
        await client.get('https://www.nasa.gov/rss/dyn/breaking_news.rss');
    var channel = new RssFeed.parse(response.body);
    return channel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFeed(),
      builder: (context, feed) {
        if (feed.connectionState == ConnectionState.waiting)
          return NativeLoadingIndicator(
            center: true,
            text: Text('Loading...'),
          );

        if (feed.connectionState == ConnectionState.done) {
          if (feed.data?.items == null || feed.data.items.isEmpty)
            return Center(child: Text('No Feed Found'));

          return ListView.builder(
            itemCount: feed.data.items.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(feed.data.items[index].title),
                subtitle: Text(feed.data.items[index].description),
              );
            },
          );
        }
      },
    );
  }
}
