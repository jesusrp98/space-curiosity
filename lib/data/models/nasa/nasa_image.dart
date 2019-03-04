import 'dart:convert';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_news/data/classes/nasa/image.dart';

import '../../../util/url.dart';
import '../models.dart';

class NasaImagesModel extends QueryModel {
  @override
  Future loadData() async {
    var _local = await _loadItemsLocal();

    if (_local != null && _local.isNotEmpty) {
      items.addAll(_local);
    }

    _updateLocal();

    setLoading(false);
  }
}

void _updateLocal() async {
  try {
    final response = await http.get(Url.dailyPicture);
    final moreResponse = await http.get(Url.morePictures);
    final List<dynamic> _moreImages = json.decode(moreResponse.body);
    List _items = [];
    _items.add(NasaImage.fromJson(json.decode(response.body)));
    _items
        .addAll(_moreImages.map((image) => NasaImage.fromJson(image)).toList());
    _saveItemsLocal(_items);
  } catch (e) {
    print(e);
  }
}

void _saveItemsLocal(List items) async {
  final prefs = await SharedPreferences.getInstance();
  var _local = await _loadItemsLocal();
  List _itemsToSave = _local;

  for (var item in items) {
    if (!_local.contains(item)) {
      _itemsToSave.add(item);
    }
  }

  try {
    prefs.setStringList(
      'nasa_images',
      _itemsToSave.map((image) => json.encode(image.toJson())).toList(),
    );
  } catch (e) {
    print("Could not update local => $e");
  }
}

Future<List> _loadItemsLocal() async {
  final prefs = await SharedPreferences.getInstance();
  List<NasaImage> _items = [];
  try {
    List<String> _localItems = prefs.getStringList('nasa_images');
    for (String item in _localItems) {
      _items.add(NasaImage.fromJson(json.decode(item)));
    }
    ;
  } catch (error) {
    print("Error Loading Images from Local $error");
  }
  return _items;
}
