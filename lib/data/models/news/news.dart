import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../repositories/posts/news.dart';
import '../models.dart';

class NewsModel extends ChangeNotifier {
  final http.Client httpClient = http.Client();

  bool _error = false;
  int _limit = 20;
  bool _loading = false;
  List<Post> _posts = [];
  int _startIndex = 0;

  List<Post> get posts => _posts;

  bool get isError => _error;

  bool get isLoading => _loading;

  void init() async {
    await refresh();
  }

  Future refresh() async {
    _loading = true;
    _error = false;
    notifyListeners();
    try {
      final _list = await NewsRepo(httpClient: httpClient)
          .fetchPosts(_startIndex, _limit);
      if (_list != null) {
        _posts = _list;
      }
    } catch (e) {
      _error = true;
    }

    _loading = false;
    notifyListeners();
  }
}
