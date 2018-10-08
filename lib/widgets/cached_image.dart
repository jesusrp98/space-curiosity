import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget getImagePreview(String url) {
  var _url = Uri.tryParse(url.trim());

  if (_url == null) return Icon(Icons.image_aspect_ratio, size: 60.0);

  switch (_url.toString()) {
    case 'youtube':
    case 'vimeo':
      return Icon(Icons.ondemand_video, size: 60.0);
      break;
    default:
      return CachedNetworkImage(
        imageUrl: _url.toString().trim(),
        height: 65.0,
        width: 65.0,
        fit: BoxFit.fitHeight,
        errorWidget: Icon(Icons.broken_image, size: 60.0),
      );
  }
}
