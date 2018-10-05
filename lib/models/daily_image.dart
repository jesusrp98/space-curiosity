import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async_resource/file_resource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import '../services/api.dart';
import '../util/cache_settings.dart';
import 'package:uuid/uuid.dart';
import '../util/keys.dart';

class NasaImagesModel extends Model {
  List<ImageData> _images;
  List<ImageData> get images => _images;
  int _count = 100;
  get count => _count;

  Future fetchMore() async {
    _count += 100;
    await fetchImages();
    notifyListeners();
  }

  Future refresh() async {
    _count = 100;
    await fetchImages();
    notifyListeners();
  }

  Future fetchImages() async {
    List<ImageData> _newImages;
    try {
      String _url = 'https://api.nasa.gov/planetary/apod?'
          'api_key=$apiKey&count=$count';
      final path = (await getApplicationDocumentsDirectory()).path;
      final myDataResource = HttpNetworkResource<List<ImageData>>(
        url: _url,
        parser: (contents) {
          List decoded = json.decode(contents);
          _newImages = [];
          for (Map row in decoded) {
            var _image = ImageData.fromJson(row);
            if (_image != null) _newImages.add(_image);
          }
        },
        cache: FileResource(File('$path/nasa_images.json')),
        maxAge: cacheDuration,
        strategy: cacheStrategy,
      );
      _images = await myDataResource.get();
    } catch (e) {
      print("Error Cached DailyImage: $e");
    }
    try {
      if (_newImages == null) {
        String _response = await getData('https://api.nasa.gov/planetary/apod?',
            'api_key=$apiKey&count=$count');
        List decoded = json.decode(_response);
        _newImages = [];
        print(decoded);
        for (Map row in decoded) _newImages.add(ImageData.fromJson(row));
      }
    } catch (e) {
      print('Error Creating DailyImage: $e');
    }
    if (_newImages == null) _newImages = [];
    notifyListeners();
    _images = _newImages;
  }
}

class ImageData {
  final String id, title, date, url, hdurl, description;
  ImageData({
    this.id,
    this.date,
    this.description,
    this.hdurl,
    this.title,
    this.url,
  });

  factory ImageData.fromJson(Map json) {
    var uuid = new Uuid();
    return ImageData(
      id: uuid.v4(),
      title: json['title'] ?? 'No Name Found',
      date: json['date'],
      description: json['explanation'],
      hdurl: json['hdurl'],
      url: json['url'],
    );
  }
}
