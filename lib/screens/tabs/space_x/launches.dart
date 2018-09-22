import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:space_news/models/rockets/launches.dart';
import 'package:space_news/screens/tabs/space_x/launch_page.dart';
import 'package:space_news/widgets/hero_image.dart';
import 'package:space_news/widgets/list_cell.dart';

class Launches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LaunchesModel>(
      model: LaunchesModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Launches')),
        body: ScopedModelDescendant<LaunchesModel>(
          builder: (context, child, model) => StreamBuilder(
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
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ScopedModelDescendant<LaunchesModel>(
          builder: (context, child, model) => ListCell(
                leading: HeroImage().buildHero(
                  context: context,
                  url: model.launches[index].getImageUrl,
                  tag: model.launches[index].getNumber,
                  title: model.launches[index].name,
                ),
                title: model.launches[index].name,
                subtitle: model.launches[index].getLaunchDate,
                trailing: MissionNumber(model.launches[index].getNumber),
                onTap: () => Navigator.of(context).push(
                      PageRouteBuilder<Null>(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: const Interval(0.0, 0.75,
                                        curve: Curves.fastOutSlowIn)
                                    .transform(animation.value),
                                child: LaunchPage(model.launches[index]),
                              );
                            },
                          );
                        },
                      ),
                    ),
              ),
        )
      ],
    );
  }
}
