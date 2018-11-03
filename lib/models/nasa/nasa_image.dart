import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../util/url.dart';
import '../querry_model.dart';

class NasaImagesModel extends QuerryModel {
  @override
  Future loadData() async {
    response = await http.get(Url.dailyPicture);
    final moreResponse = await http.get(Url.morePictures);

    snapshot = json.decode(moreResponse.body);
    items.add(NasaImage.fromJson(json.decode(response.body)));
    items.addAll(snapshot.map((image) => NasaImage.fromJson(image)).toList());

    loadingState(false);
  }
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

  String get getDate => DateFormat.yMMMMd().format(date);

  bool get hasCopyright => copyright != null;

  String get getCopyright =>
      hasCopyright ? copyright : 'No copyright';

  String get share => '$title\n\n$description\n\n$hdurl';
}
