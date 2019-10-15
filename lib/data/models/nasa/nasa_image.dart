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
      int retry = 5;
      while (_images == null && retry != 0) {
        try {
          await _refreshImages();
        } catch (e) {}
        retry--;
      }
      if (_images != null) items.addAll(_images);
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
    _moreImages.map((image) => NasaImage.fromJson(image)).toList();
    for (var image in _moreImages) {
      try {
        await _insertImage(image.body);
      } catch (e) {}
    }
    _images = await db.allImages().get();
  }

  final db = GetIt.instance.get<Database>();
  Future<void> _insertImage(String source) async {
    final _json = json.decode(source);
    await db.insertImage(
      _json['url'],
      _json['title'],
      _json['explanation'],
      _json['copyright'],
      _json['date'],
    );
  }
}
