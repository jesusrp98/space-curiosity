import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// HERO IMAGE
/// Class used into building hero images & their specific hero pages.
class HeroImage extends StatelessWidget {
  static const num smallSize = 64.0, bigSize = 100.0;

  final String url, tag;
  final num size;
  final VoidCallback onTap;

  HeroImage({this.url, this.tag, this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: onTap,
        child: Hero(
          tag: tag,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            errorWidget: const Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 100),
          ),
        ),
      ),
    );
  }

  factory HeroImage.list({String url, String tag, num size}) {
    return HeroImage(url: url, tag: tag, size: size, onTap: null);
  }

  factory HeroImage.card({
    String url,
    String tag,
    num size,
    VoidCallback onTap,
  }) {
    return HeroImage(url: url, tag: tag, size: size, onTap: onTap);
  }
}
