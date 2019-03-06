// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NasaImages _$NasaImagesFromJson(Map<String, dynamic> json) {
  return NasaImages(
      images: (json['images'] as List)
          ?.map((e) =>
              e == null ? null : NasaImage.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NasaImagesToJson(NasaImages instance) =>
    <String, dynamic>{'images': instance.images};
