import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../repositories/posts/news.dart';
import '../bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc(this.httpClient);

  @override
  Stream<PostEvent> transform(Stream<PostEvent> events) {
    return (events as Observable<PostEvent>).debounce(
      Duration(milliseconds: 500),
    );
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(currentState, event) async* {
    if (event is Fetch) {
      final posts = await NewsRepo(httpClient: httpClient).fetchPosts(0, 20);
      yield PostLoaded(posts: posts, hasReachedMax: false);
    }
  }
}
