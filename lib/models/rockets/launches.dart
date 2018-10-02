import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/models/rockets/launch.dart';
import 'package:http/http.dart' as http;
import 'package:space_news/util/url.dart';

class LaunchesModel extends Model {
  List<Launch> _launches;
  bool _isLoading = true;

  Future loadData() async {
    final response = await http.get(Url.launches);

    List jsonDecoded = json.decode(response.body);
    _launches = jsonDecoded.map((m) => Launch.fromJson(m)).toList();
    
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  List<Launch> get launches => _launches;
}