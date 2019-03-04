import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../../classes/articles/post.dart';
import '../bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  Stream<PostEvent> transform(Stream<PostEvent> events) {
    return (events as Observable<PostEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(currentState, event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState.posts + posts)?.toSet()?.toList(),
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient
        .get('https://www.nasa.gov/rss/dyn/breaking_news.rss/$startIndex');

    if (response.statusCode == 200) {
      var channel = new RssFeed.parse(response.body);
      final data = channel?.items;
      return data.map((rawPost) {
        return Post(
          id: data?.indexOf(rawPost),
          title: rawPost?.title,
          body: rawPost?.description,
          date: rawPost?.pubDate,
          url: rawPost?.link,
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
