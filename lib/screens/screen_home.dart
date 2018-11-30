import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/screens/tabs/iss/screen_iss.dart';

import '../models/nasa/nasa_image.dart';
import '../models/planets/celestial_body.dart';
import '../widgets/list_cell.dart';
import '../widgets/photo_card.dart';
import 'screen_about.dart';
import 'tabs/news/screen_news.dart';
import 'tabs/planets/screen_solar_system.dart';
import 'tabs/space_x/screen_spacex.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutScreen()),
                ),
          ),
        ],
        title: Text(
          FlutterI18n.translate(context, 'app.title'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ContentPage(),
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
            padding: const EdgeInsets.all(16.0),
            child: ScopedModel<NasaImagesModel>(
              model: _nasaModel,
              child: _buildNasaImage(),
            ),
          ),
        ),
        const Divider(height: 0.0),
        ListCell(
          leading: Icon(FontAwesomeIcons.rocket, size: 36.0),
          title: 'SpaceX',
          subtitle: 'Launch Tracker',
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IssScreen()),
              ),
        ),
        const Divider(height: 0.0, indent: 68.0),
        ListCell(
          leading: Icon(Icons.description, size: 36.0),
          title: 'Breaking News',
          subtitle: 'From around the globe',
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewsScreen()),
              ),
        ),
        const Divider(height: 0.0, indent: 68.0),
        ListCell(
          leading: Icon(Icons.public, size: 36.0),
          title: 'Solar System',
          subtitle: 'Explore every inch of our neighborhood',
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScopedModel<PlanetsModel>(
                        model: _planetsModel,
                        child: SolarSystemScreen(
                          planetModel: _planetsModel,
                        ),
                      ),
                ),
              ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       HomeIcon(
        //         icon: FontAwesomeIcons.rocket,
        //         title: 'SpaceX',
        //         screen: SpacexScreen(),
        //       ),
        //       HomeIcon(
        //         icon: Icons.description,
        //         title: 'News',
        //         screen: NewsScreen(),
        //       ),
        //       HomeIcon(
        //         icon: Icons.public,
        //         title: 'Solar System',
        //         screen: ScopedModel<PlanetsModel>(
        //           model: _planetsModel,
        //           child: SolarSystemScreen(
        //             planetModel: _planetsModel,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // )
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
