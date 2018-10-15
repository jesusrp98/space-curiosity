import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../util/url.dart';
import '../general_model.dart';

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

  String get getDate => DateFormat.yMMMMd().format(date);

  bool get hasCopyright => copyright != null;

  String get getCopyright =>
      hasCopyright ? 'Copyright: $copyright' : 'No copyright';

  String get share => '$title\n\n$description\n\n$hdurl';
}

class NasaImagesModel extends GeneralModel {
  @override
  Future loadData() async {
    final response = await http.get(Url.morePictures);

    list.clear();
    List jsonDecoded = json.decode(response.body);
    list.addAll(jsonDecoded.map((image) => NasaImage.fromJson(image)).toList());

    loadingState(false);
  }

  Future loadDaily() async {
    final response = await http.get(Url.dailyPicture);

    list.clear();
    list.add(NasaImage.fromJson(json.decode(response.body)));

    loadingState(false);
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:async_resource/file_resource.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:uuid/uuid.dart';

// import '../services/api.dart';
// import '../util/cache_settings.dart';
// import '../util/keys.dart';

// class NasaImagesModel extends Model {
//   List<ImageData> _images;
//   List<ImageData> get images => _images;
//   int _count = 2;
//   get count => _count;

//   Future fetchMore() async {
//     _count += 100;
//     await fetchImages();
//     notifyListeners();
//   }

//   Future refresh() async {
//     _count = 100;
//     await fetchImages();
//     notifyListeners();
//   }

//   Future fetchImages() async {
//     List<ImageData> _newImages;
//     try {
//       String _url = 'https://api.nasa.gov/planetary/apod?'
//           'api_key=$apiKey&count=$count';
//       final path = (await getApplicationDocumentsDirectory()).path;
//       final myDataResource = HttpNetworkResource<List<ImageData>>(
//         url: _url,
//         parser: (contents) {
//           List decoded = json.decode(contents);
//           _newImages = [];
//           for (Map row in decoded) {
//             var _image = ImageData.fromJson(row);
//             if (_image != null) _newImages.add(_image);
//           }
//         },
//         cache: FileResource(File('$path/nasa_images.json')),
//         maxAge: cacheDuration,
//         strategy: cacheStrategy,
//       );
//       _images = await myDataResource.get();
//     } catch (e) {
//       print("Error Cached DailyImage: $e");
//     }
//     try {
//       if (_newImages == null) {
//         String _response = await getData('https://api.nasa.gov/planetary/apod?',
//             'api_key=$apiKey&count=$count');
//         List decoded = json.decode(_response);
//         _newImages = [];
//         print(decoded);
//         for (Map row in decoded) _newImages.add(ImageData.fromJson(row));
//       }
//     } catch (e) {
//       print('Error Creating DailyImage: $e');
//     }
//     if (_newImages == null) _newImages = [];
//     notifyListeners();
//     _images = _newImages;
//   }
// }
