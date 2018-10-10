import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/screens/tabs/nasa/imagedetails.dart';
import 'package:space_news/util/axis_count.dart';
import 'package:space_news/util/colors.dart';

import '../models/daily_image.dart';
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
      body: Column(
        children: <Widget>[
          ScopedModel<NasaImagesModel>(
            model: NasaImagesModel(),
            child: _buildNasaCards(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HomeIcon(
                  icon: FontAwesomeIcons.rocket,
                  title: 'SpaceX',
                  screen: SpacexScreen(),
                ),
                HomeIcon(
                  icon: Icons.description,
                  title: 'Breaking news',
                  screen: NewsScreen(),
                ),
                HomeIcon(
                  icon: Icons.public,
                  title: 'Solar System',
                  screen: SolarSystemScreen(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNasaCards() {
    return ScopedModelDescendant<NasaImagesModel>(
      builder: (context, child, model) => StreamBuilder(
            stream: model.fetchImages().asStream().distinct(),
            builder: (BuildContext context, _) {
              if (model.images == null)
                return NativeLoadingIndicator(center: true);

              if (model.images.isEmpty)
                return Center(child: Text("No Images Found"));
              int axisCount = getAxisCount(context);

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: axisCount),
                itemCount: model.images.length,
                itemBuilder: (context, index) {
                  model.fetchMore();
                  String content = model.images[index]?.hdurl ??
                      model.images[index]?.url ??
                      "";

                  return InkWell(
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ImageDetailsPage(
                            image: model.images[index],
                            currentImage: content,
                          );
                        })),
                    onLongPress: () => FlutterWebBrowser.openWebPage(
                          url: content,
                          androidToolbarColor: primaryColor,
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: GridTile(
                        header: Text(
                          model.images[index]?.title ?? "",
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        child: Hero(
                          tag: model.images[index].id,
                          child: Image.network(content),
                        ),
                        footer: Text(
                          model.images[index]?.date ?? "",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}
