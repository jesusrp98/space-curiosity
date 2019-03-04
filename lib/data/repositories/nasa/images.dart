import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../util/url.dart';
import '../../classes/nasa/image.dart';

class NasaImageRepo {
  final http.Client httpClient;

  NasaImageRepo({@required this.httpClient});

  Future<List<NasaImage>> get images async {
    List<NasaImage> _items = [];
    try {
      final response = await httpClient.get(Url.dailyPicture);
      final moreResponse = await httpClient.get(Url.morePictures);
      final List<dynamic> _moreImages = json.decode(moreResponse.body);

      _items.add(
        NasaImage.fromJson(json.decode(response.body)),
      );
      _items.addAll(
        _moreImages.map((image) => NasaImage.fromJson(image)).toList(),
      );
    } catch (e) {
      print(e);
    }
    return _items;
  }
}
