import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../../classes/articles/post.dart';

class NewsRepo {
  final http.Client httpClient;

  NewsRepo({@required this.httpClient});

  Future<List<Post>> fetchPosts(int startIndex, int limit) async {
    // final response = await httpClient
    //     .get('https://www.nasa.gov/rss/dyn/breaking_news.rss/$startIndex');

    // if (response.statusCode == 200) {
    //   var channel = new RssFeed.parse(response.body);
    //   final data = channel?.items;
    //   return data.map((rawPost) {
    //     return Post(
    //       id: data?.indexOf(rawPost),
    //       title: rawPost?.title,
    //       body: rawPost?.description,
    //       date: rawPost?.pubDate,
    //       url: rawPost?.link,
    //     );
    //   }).toList();
    // } else {
    //   throw Exception('error fetching posts');
    // }

    final response = await httpClient.get('https://www.space.com/feeds/all');
    print("Result:${response.statusCode} => ${response?.body}");

    try {
      return RssFeed.parse(response.body)
          .items
          .map((item) => Post.fromRss(item))
          .toList();
    } catch (e) {
      print("Error Parsing XML: $e");
      return [];
    }
  }
}
