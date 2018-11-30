import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/nasa/nasa_image.dart';
import '../models/planets/celestial_body.dart';
import '../widgets/list_cell.dart';
import '../widgets/photo_card.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, 'app.title'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (_) => ['About the app', 'Customize']
                .map((text) => PopupMenuItem(
                      value: text,
                      child: Text(text),
                    ))
                .toList(),
            onSelected: (_) => {},
          )
        ],
        centerTitle: true,
      ),
      body: ContentPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.menu),
        label: Text('Main menu'),
        onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.expand_more,
                          size: 24.0,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            ListCell(
                              leading: Icon(
                                FontAwesomeIcons.rocket,
                                size: 42,
                              ),
                              title: 'SpaceX tracker',
                              subtitle: 'Elon Musk & company experiments',
                              onTap: () => openPage(context, '/spacex'),
                            ),
                            const Divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: Icon(
                                Icons.description,
                                size: 42,
                              ),
                              title: 'Latest news',
                              subtitle: 'Headlines from around the globe',
                              onTap: () => openPage(context, '/news'),
                            ),
                            const Divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: Icon(
                                Icons.public,
                                size: 42,
                              ),
                              title: 'Solar System',
                              subtitle:
                                  'Explore every inch of our neighborhood',
                              onTap: () => openPage(context, '/planets'),
                            ),
                            const Divider(height: 0.0, indent: 74.0),
                            ListCell(
                                leading: Icon(
                                  Icons.my_location,
                                  size: 42,
                                ),
                                title: 'ISS tracker',
                                subtitle: 'They\'re floating above us!',
                                onTap: () => openPage(context, '/iss')),
                            const Divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: Icon(
                                Icons.fitness_center,
                                size: 42,
                              ),
                              title: 'Weight calculator',
                              subtitle: 'Does Mars makes me fatter?',
                              // COMING SOON!
                            ),
                            const Divider(height: 0.0, indent: 74.0),
                            ListCell(
                              leading: Icon(
                                Icons.camera_alt,
                                size: 42,
                              ),
                              title: 'Dear Mars',
                              subtitle:
                                  'All about the red planet & its inhabitants',
                              // COMING SOON!
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
    Navigator.of(context).pushNamed(route);
  }
}

class ContentPage extends StatefulWidget {
  const ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  NasaImagesModel _nasaModel;
  PlanetsModel _planetsModel;

  @override
  void initState() {
    _nasaModel = NasaImagesModel();
    _planetsModel = PlanetsModel();
    _nasaModel.loadData().then((_) => setState(() {}));
    _planetsModel.loadData().then((_) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ScopedModel<NasaImagesModel>(
              model: _nasaModel,
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
          : Swiper(
              itemBuilder: (_, index) => PhotoCard(model.getItem(index)),
              scrollDirection: Axis.vertical,
              itemCount: model.getSize,
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
