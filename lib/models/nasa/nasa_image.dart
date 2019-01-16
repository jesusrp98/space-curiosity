import 'dart:convert';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/url.dart';
import '../querry_model.dart';

class NasaImagesModel extends QuerryModel {
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
    print(Url.dailyPicture);
    final moreResponse = await http.get(Url.morePictures);
    final List<dynamic> _moreImages = json.decode(moreResponse.body);
    print(Url.morePictures);
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
      print("Items => $item");
      print(NasaImage.fromJson(json.decode(item)).title);
    };
  } catch (error) {
    print("Error Loading Images from Local $error");
  }
  return _items;
}

class NasaImage {
  final String title, description, url, hdurl, copyright;
  final DateTime date;

  NasaImage({
    this.title,
    this.description,
    this.url,
    this.hdurl,
    this.copyright,
    this.date,
  });

  factory NasaImage.fromJson(Map<String, dynamic> json) {
    return NasaImage(
      title: json['title'] ?? 'No Name Found',
      description: json['explanation'],
      url: json['url'],
      hdurl: json['hdurl'],
      copyright: json['copyright'],
      date: DateTime.parse(json['date']),
    );
  }
  Map<String, dynamic> toJson() => {
        'title': title,
        'explanation': description,
        'url': url,
        'hdurl': hdurl,
        'copyright': copyright,
        'date': date.toString(),
      };

  // TODO revisar esto
  String get getDate {
    if (date == null) return DateTime.now().millisecondsSinceEpoch.toString();
    try {
      return DateFormat.yMMMMd('en_US').format(date);
    } catch (e) {
      print(e);
      return '';
    }
  }

  String getCopyright(context) =>
      copyright ?? FlutterI18n.translate(context, 'nasa.no_copyright');

  String share(context) =>
      '$title\n\n$description\n\n${getCopyright(context)} · $getDate\n\n$hdurl';
}
