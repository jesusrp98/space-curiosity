import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class NasaImage {
  final String title, url, hdurl, copyright;

  final DateTime date;

  @JsonKey(name: "explanation", nullable: true)
  final String description;

  NasaImage({
    this.title,
    this.description,
    this.url,
    this.hdurl,
    this.copyright,
    this.date,
  });

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

  factory NasaImage.fromJson(Map<String, dynamic> json) =>
      _$NasaImageFromJson(json);

  Map<String, dynamic> toJson() => _$NasaImageToJson(this);
}
