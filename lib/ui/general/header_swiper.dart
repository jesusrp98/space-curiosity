import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:space_news/plugins/url_launcher/url_launcher.dart';

import 'index.dart';

/// Used as a sliver header, in the [background] parameter.
/// It allows the user to scroll throug multiple shots.
class SwiperHeader extends StatelessWidget {
  final List list;
  final IndexedWidgetBuilder builder;

  const SwiperHeader({
    @required this.list,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: list.length,
      itemBuilder: builder ?? (context, index) => CacheImage(list[index]),
      curve: Curves.easeInOutCubic,
      autoplayDelay: 5000,
      autoplay: true,
      duration: 850,
      onTap: (index) => UrlUtils.open(
        url: list[index],
        androidToolbarColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
