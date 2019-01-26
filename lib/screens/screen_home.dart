import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/nasa/nasa_image.dart';
import '../widgets/call_error.dart';
import '../widgets/list_cell.dart';
import '../widgets/photo_card.dart';
import '../widgets/separator.dart';

class HomeScreen extends StatelessWidget {
  static final Map<String, String> _menu = {
    'home.menu.about': '/about',
    'home.menu.settings': '/settings'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, 'app.title'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (_) => _menu.keys
                .map((string) => PopupMenuItem(
                      value: string,
                      child: Text(
                        FlutterI18n.translate(context, string),
                      ),
                    ))
                .toList(),
            onSelected: (string) => Navigator.pushNamed(context, _menu[string]),
          ),
        ],
        centerTitle: true,
      ),
      body: ContentPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.menu),
        label: Text(FlutterI18n.translate(context, 'home.page.fab')),
        onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(Icons.expand_more, size: 24.0),
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            ListCell(
                              leading: const Icon(
                                FontAwesomeIcons.rocket,
                                size: 42,
                              ),
                              title: FlutterI18n.translate(
                                context,
                                'home.page.menu.spacex.title',
                              ),
                              subtitle: FlutterI18n.translate(
                                context,
                                'home.page.menu.spacex.body',
                              ),
                              onTap: () => openPage(context, '/spacex'),
                            ),
                            Separator.divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: Icon(
                                Icons.description,
                                size: 42,
                              ),
                              title: FlutterI18n.translate(
                                context,
                                'home.page.menu.news.title',
                              ),
                              subtitle: FlutterI18n.translate(
                                context,
                                'home.page.menu.news.body',
                              ),
                              onTap: () => openPage(context, '/news'),
                            ),
                            Separator.divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: const Icon(Icons.public, size: 42),
                              title: FlutterI18n.translate(
                                context,
                                'home.page.menu.planets.title',
                              ),
                              subtitle: FlutterI18n.translate(
                                context,
                                'home.page.menu.planets.body',
                              ),
                              onTap: () => openPage(context, '/planets'),
                            ),
                            Separator.divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: const Icon(Icons.my_location, size: 42),
                              title: FlutterI18n.translate(
                                context,
                                'home.page.menu.iss.title',
                              ),
                              subtitle: FlutterI18n.translate(
                                context,
                                'home.page.menu.iss.body',
                              ),
                              onTap: () => openPage(context, '/iss'),
                            ),
                            Separator.divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: const Icon(
                                Icons.fitness_center,
                                size: 42,
                              ),
                              title: FlutterI18n.translate(
                                context,
                                'home.page.menu.weight.title',
                              ),
                              subtitle: FlutterI18n.translate(
                                context,
                                'home.page.menu.weight.body',
                              ),
                              onTap: () => openPage(context, '/weight'),
                            ),
                            Separator.divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: const Icon(Icons.camera_alt, size: 42),
                              title: FlutterI18n.translate(
                                context,
                                'home.page.menu.mars.title',
                              ),
                              subtitle: FlutterI18n.translate(
                                context,
                                'home.page.menu.mars.body',
                              ),
                              onTap: () => openPage(context, '/mars'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
      ),
    );
  }

  openPage(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
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
            child: ScopedModel<NasaImagesModel>(
              model: NasaImagesModel()..loadData(),
              child: _buildNasaImage(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNasaImage() {
    return ScopedModelDescendant<NasaImagesModel>(
      builder: (context, child, model) => model.isLoading
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
