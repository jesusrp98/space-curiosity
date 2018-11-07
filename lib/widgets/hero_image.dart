import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// HERO IMAGE
/// Class used into building hero images & their specific hero pages.
class HeroImage extends StatelessWidget {
  static const num _smallSize = 64.0, _bigSize = 100.0;

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

  factory HeroImage.list({String url, String tag}) {
    return HeroImage(url: url, tag: tag, size: _smallSize, onTap: null);
  }

  factory HeroImage.card({
    String url,
    String tag,
    VoidCallback onTap,
  }) {
    return HeroImage(url: url, tag: tag, size: _bigSize, onTap: onTap);
  }
}
