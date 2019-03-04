import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../../classes/articles/post.dart';

class NewsRepo {
  final http.Client httpClient;

  NewsRepo({@required this.httpClient});

  Future<List<Post>> fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get('https://www.space.com/feeds/all');
    // print("Result:${response.statusCode} => ${response?.body}");

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
