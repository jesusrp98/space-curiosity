import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/nasa/nasa_image.dart';
import '../models/planets/celestial_body.dart';
import '../util/colors.dart';
import '../widgets/photo_card.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        title: Text(
          FlutterI18n.translate(context, 'app.title'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ContentPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.share),
        label: Text('Share image'),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Menu',
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
                                  ListTile(
                                    leading: Icon(FontAwesomeIcons.rocket),
                                    title: Text('SpaceX'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context)
                                          .pushNamed('/spacex');
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.description),
                                    title: Text('News'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushNamed('/news');
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.public),
                                    title: Text('Solar System'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context)
                                          .pushNamed('/planets');
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.my_location),
                                    title: Text('ISS tracker'),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.fitness_center),
                                    title: Text('Weight calculator'),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                  ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Actions',
              onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.expand_more,
                                size: 24.0,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.info),
                              title: Text('About this app'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed('/info');
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Customize your experience'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed('/settings');
                              },
                            ),
                          ],
                        ),
                  ),
            )
          ],
        ),
      ),
    );
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
              itemBuilder: (context, index) => ScopedModel<NasaImagesModel>(
                    model: _nasaModel,
                    child: ScopedModelDescendant<NasaImagesModel>(
                      builder: (context, child, model) => model.isLoading
                          ? NativeLoadingIndicator(center: true)
                          : PhotoCard(model.getItem(index)),
                    ),
                  ),
              scrollDirection: Axis.vertical,
              itemCount: _nasaModel.getSize,
              itemWidth: 500.0,
              itemHeight: 500.0,
              layout: SwiperLayout.STACK,
            ),
    );
  }
}
