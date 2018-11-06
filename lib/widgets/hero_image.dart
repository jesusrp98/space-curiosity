import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// HERO IMAGE
/// Class used into building hero images & their specific hero pages.
class HeroImage extends StatelessWidget {
  static const num smallSize = 64.0, bigSize = 112.0;

  final String url, tag;
  final num size;
  final VoidCallback onTap;

  HeroImage({this.url, this.tag, this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              errorWidget: const Icon(Icons.error),
              fadeInDuration: Duration(milliseconds: 100),
            ),
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

  // /// Builds a hero image
  // Widget buildHero({
  //   BuildContext context,
  //   double size,
  //   String url,
  //   String tag,
  //   String title,
  // }) {
  //   return Container(
  //     width: size,
  //     height: size,
  //     child: Hero(
  //       tag: tag,
  //       child: _Image(url: url, size: smallSize),
  //     ),
  //   );
  // }

  // /// Builds a expanded hero image
  // Widget buildExpandedHero({
  //   BuildContext context,
  //   double size,
  //   String url,
  //   String tag,
  //   String title,
  // }) {
  //   return Container(
  //     width: size,
  //     height: size,
  //     child: Hero(
  //       tag: tag,
  //       child: _Image(
  //         url: url,
  //         size: bigSize,
  //         onTap: () => FlutterWebBrowser.openWebPage(
  //               url: url,
  //               androidToolbarColor: primaryColor,
  //             ),
  //       ),
  //     ),
  //   );
  // }
}

/// IMAGE CLASS
/// Private class which receives an image url & more to display a image network.
// class _Image extends StatelessWidget {
//   final String url;
//   final double size;
//   final VoidCallback onTap;

//   _Image({
//     this.url,
//     this.size,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: size,
//       height: size,
//       child: ClipRect(
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: onTap,
//             child: CachedNetworkImage(
//               imageUrl: url,
//               fit: BoxFit.cover,
//               errorWidget: const Icon(Icons.error),
//               fadeInDuration: Duration(milliseconds: 100),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
