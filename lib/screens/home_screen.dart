import 'package:flutter/material.dart';
import 'package:space_news/screens/about_screen.dart';
import 'package:space_news/screens/tabs/news_screen.dart';
import 'package:space_news/screens/tabs/solar_system_screen.dart';
import 'package:space_news/screens/tabs/space_x/spacex_screen.dart';
import 'package:space_news/widgets/home_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          _buildNasaCards(),
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
    return Container();
//    return ScopedModelDescendant<NasaImagesModel>(
//      builder: (context, child, model) => StreamBuilder(
//            stream: model.fetchImages().asStream().distinct(),
//            builder: (BuildContext context, _) {
//              if (model.images == null)
//                return NativeLoadingIndicator(
//                  center: true,
//                  text: Text("Loading..."),
//                );
//
//              if (model.images.isEmpty)
//                return Center(child: Text("No Images Found"));
//              int axisCount = getAxisCount(context);
//
//              return GridView.builder(
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: axisCount),
//                itemCount: model.images.length,
//                itemBuilder: (context, index) {
//                  model.fetchMore();
//                  String content = model.images[index]?.hdurl ??
//                      model.images[index]?.url ??
//                      "";
//
//                  return InkWell(
//                    onTap: () =>
//                        Navigator.push(context, MaterialPageRoute(builder: (_) {
//                          return ImageDetailsPage(
//                            image: model.images[index],
//                            currentImage: content,
//                          );
//                        })),
//                    onLongPress: () => FlutterWebBrowser.openWebPage(
//                          url: content,
//                          androidToolbarColor: primaryColor,
//                        ),
//                    child: Padding(
//                      padding: const EdgeInsets.all(1.0),
//                      child: GridTile(
//                        header: Text(
//                          model.images[index]?.title ?? "",
//                          maxLines: 1,
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 14.0,
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                        child: Hero(
//                          tag: model.images[index].id,
//                          child: Image.network(content),
//                        ),
//                        footer: Text(
//                          model.images[index]?.date ?? "",
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                    ),
//                  );
//                },
//              );
//            },
//          ),
//    );
  }
}
