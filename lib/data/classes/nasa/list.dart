import 'package:json_annotation/json_annotation.dart';
import 'package:space_news/data/classes/nasa/image.dart';

part 'list.g.dart';

@JsonSerializable()
class NasaImages {
  NasaImages({
    this.images,
  });

  List<NasaImage> images;

  factory NasaImages.fromJson(Map<String, dynamic> json) =>
      _$NasaImagesFromJson(json);

  Map<String, dynamic> toJson() => _$NasaImagesToJson(this);
}
