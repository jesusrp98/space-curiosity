import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/models/rockets/launches.dart';
import 'package:space_news/screens/tabs/space_x/launch_page.dart';
import 'package:space_news/widgets/hero_image.dart';
import 'package:space_news/widgets/list_cell.dart';

class LaunchesTab extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Null> _onRefresh(LaunchesModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LaunchesModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text('Launches')),
            body: ScopedModelDescendant<LaunchesModel>(
              builder: (context, child, model) => SafeArea(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () => _onRefresh(model),
                      child: StreamBuilder(
                        stream: model.loadData().asStream().distinct(),
                        builder: (BuildContext context, _) {
                          if (model.launches == null)
                            return NativeLoadingIndicator(
                              center: true,
                              text: Text("Loading..."),
                            );

                          if (model.launches.isEmpty)
                            return Center(child: Text("No launches Found"));

                          return ListView.builder(
                            itemCount: model.launches.length,
                            itemBuilder: _buildItem,
                          );
                        },
                      ),
                    ),
                  ),
            ),
          ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<LaunchesModel>(
            builder: (context, child, model) => Column(
                  children: <Widget>[
                    ListCell(
                      leading: HeroImage().buildHero(
                        context: context,
                        size: HeroImage.smallSize,
                        url: model.launches[index].getImageUrl,
                        tag: model.launches[index].getNumber,
                        title: model.launches[index].name,
                      ),
                      title: model.launches[index].name,
                      subtitle: model.launches[index].getLaunchDate,
                      trailing: MissionNumber(model.launches[index].getNumber),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LaunchPage(model.launches[index]),
                            ),
                          ),
                    ),
                    const Divider(height: 0.0, indent: 104.0)
                  ],
                ))
      ],
    );
  }
}
