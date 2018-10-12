import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/widgets/hero_image.dart';
import '../widgets/photo_card.dart';

import '../models/daily_image.dart';
import '../models/planets/planets.dart';
import '../widgets/home_icon.dart';
import 'screen_about.dart';
import 'tabs/screen_news.dart';
import 'tabs/screen_solar_system.dart';
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
        title: const Text(
          'Space Curiosity',
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
            padding: const EdgeInsets.all(32.0),
            child: ScopedModel<NasaImagesModel>(
              model: _nasaModel,
              child: _buildNasaImage(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              HomeIcon(
                icon: FontAwesomeIcons.rocket,
                title: 'SpaceX',
                screen: SpacexScreen(),
              ),
              HomeIcon(
                icon: Icons.description,
                title: 'News',
                screen: NewsScreen(),
              ),
              HomeIcon(
                icon: Icons.public,
                title: 'Solar System',
                screen: ScopedModel<PlanetsModel>(
                  model: _planetsModel,
                  child: SolarSystemScreen(
                    planetModel: _planetsModel,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNasaImage() {
    return ScopedModelDescendant<NasaImagesModel>(
      builder: (context, child, model) => model.isLoading
          ? NativeLoadingIndicator(center: true)
          : PhotoCard(
              image: Hero(
                tag: (model.list[0] as NasaImage).getDate,
                child: Image.network(
                  (model.list[0] as NasaImage).hdurl,
                  fit: BoxFit.fitHeight,
                ),
              ),
              title: (model.list[0] as NasaImage).title,
              subtitle: (model.list[0] as NasaImage).getDate,
              url: (model.list[0] as NasaImage).url,
            ),
    );
  }
  // Widget _buildNasaCards() {
  //   return ScopedModelDescendant<DailyImageModel>(
  //     builder: (context, child, model) => StreamBuilder(
  //           stream: model.fetchImages().asStream().distinct(),
  //           builder: (BuildContext context, _) {
  //             if (model.images == null)
  //               return NativeLoadingIndicator(center: true);

  //             if (model.images.isEmpty)
  //               return Center(child: Text("No Images Found"));
  //             int axisCount = getAxisCount(context);

  //             return GridView.builder(
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: axisCount),
  //               itemCount: model.images.length,
  //               itemBuilder: (context, index) {
  //                 model.fetchMore();
  //                 String content = model.images[index]?.hdurl ??
  //                     model.images[index]?.url ??
  //                     "";

  //                 return InkWell(
  //                   onTap: () =>
  //                       Navigator.push(context, MaterialPageRoute(builder: (_) {
  //                         return ImageDetailsPage(
  //                           image: model.images[index],
  //                           currentImage: content,
  //                         );
  //                       })),
  //                   onLongPress: () => FlutterWebBrowser.openWebPage(
  //                         url: content,
  //                         androidToolbarColor: primaryColor,
  //                       ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(1.0),
  //                     child: GridTile(
  //                       header: Text(
  //                         model.images[index]?.title ?? "",
  //                         maxLines: 1,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 14.0,
  //                         ),
  //                         textAlign: TextAlign.center,
  //                       ),
  //                       child: Hero(
  //                         tag: model.images[index].id,
  //                         child: Image.network(content),
  //                       ),
  //                       footer: Text(
  //                         model.images[index]?.date ?? "",
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //   );
  // }
}
