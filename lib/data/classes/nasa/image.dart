import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

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
