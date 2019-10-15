import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../../util/url.dart';
import '../../database/database.dart';
import '../models.dart';

class NasaImagesModel extends QueryModel {
  Future loadData([BuildContext context]) async {
    try {
      _images = await db.allImages().get();
      if (_images != null && _images.isNotEmpty) {
        items.addAll(_images);
        finishLoading();
      }
    } catch (e) {}
    try {
      await _refreshImages();
      if (_images != null) {
        items.clear();
        items.addAll(_images);
      }
    } catch (e) {
      print("Error Loading Images: $e");
    }
    finishLoading();
  }

  List<NasaImage> _images;

  Future<void> _refreshImages() async {
    final response = await http.get(Url.dailyPicture);
    print("1 => ${response.body}");
    try {
      await _insertImage(response.body);
    } catch (e) {}
    final moreResponse = await http.get(Url.morePictures);
    print("2 => ${moreResponse.body}");
    final List<dynamic> _moreImages = json.decode(moreResponse.body);
    for (var image in _moreImages) {
      try {
        final _json = json.encode(image);
        await _insertImage(_json);
      } catch (e) {}
    }
    _images = await db.allImages().get();
  }

  final db = GetIt.instance.get<Database>();
  Future<void> _insertImage(String source) async {
    final _json = json.decode(source);
    try {
      final _type = _json['media_type'];
      if (_type == 'image') {
        final _url = _json['hdurl'] ?? _json['url'];
        final _title = _json['title'].toString();
        final _description = _json['explanation'].toString();
        final _copyright = _json['copyright'].toString();
        final _date = DateTime.now();
        print('Image -> $_title : $_url');
        await db.insertImage(
          _url,
          _title ?? 'No Title',
          _description ?? 'No Description',
          _copyright ?? 'No Copyright',
          _date,
        );
      }
    } catch (e) {
      print('Error -> $e');
    }
  }
}
