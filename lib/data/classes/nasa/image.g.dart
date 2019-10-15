// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NasaImage _$NasaImageFromJson(Map<String, dynamic> json) {
  return NasaImage(
    title: json['title'] as String,
    description: json['explanation'] as String,
    url: json['url'] as String,
    hdurl: json['hdurl'] as String,
    copyright: json['copyright'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$NasaImageToJson(NasaImage instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'hdurl': instance.hdurl,
      'copyright': instance.copyright,
      'date': instance.date?.toIso8601String(),
      'explanation': instance.description,
    };
