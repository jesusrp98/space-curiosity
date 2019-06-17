import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:provider/provider.dart';

import '../data/models/nasa/nasa_image.dart';
import 'app/app_drawer.dart';
import 'general/call_error.dart';
import 'general/photo_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, 'app.title'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ContentPage(),
      drawer: AppDrawer(),
    );
  }
}

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListenableProvider<NasaImagesModel>.value(
              value: NasaImagesModel()..loadData(),
              child: _buildNasaImage(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNasaImage() {
    return Consumer<NasaImagesModel>(
      builder: (context, model, child) => model.isLoading
          ? NativeLoadingIndicator(center: true)
          : model.items == null || model.items.isEmpty
              ? CallError(() => model.loadData())
              : Swiper(
                  itemBuilder: (_, index) => PhotoCard(model.getItem(index)),
                  scrollDirection: Axis.vertical,
                  itemCount: model?.getItemCount ?? 0,
                  autoplay: true,
                  autoplayDelay: 6000,
                  duration: 750,
                  itemWidth: MediaQuery.of(context).size.width,
                  itemHeight: MediaQuery.of(context).size.height * 0.7,
                  layout: SwiperLayout.STACK,
                ),
    );
  }
}
