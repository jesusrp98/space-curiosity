import 'package:flutter/material.dart';

import '../../data/models/planets/celestial_body.dart';

class SolarSystemScreen extends StatelessWidget {
  final PlanetsModel planetModel;
  SolarSystemScreen({@required this.planetModel});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return ScopedModel(
    //   model: planetModel,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(
    //         'Solar System',
    //         style: TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //       centerTitle: true,
    //     ),
    //     body: ScopedModelDescendant<PlanetsModel>(
    //         builder: (context, child, model) {
    //       if (model.isLoading) {
    //         model.refresh();
    //         return NativeLoadingIndicator(center: true);
    //       } else {
    //         return Scrollbar(
    //           child: ListView.builder(
    //             key: PageStorageKey('planets'),
    //             itemCount: model.getItemCount,
    //             itemBuilder: _buildItem,
    //           ),
    //         );
    //       }
    //     }),
    //     floatingActionButton: FloatingActionButton(
    //       child: const Icon(Icons.add),
    //       onPressed: () => Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (_) =>
    //                   AddEditPlanetPage(null, type: BodyType.planet),
    //               fullscreenDialog: true,
    //             ),
    //           ),
    //     ),
    //   ),
    // );
  }

  // Widget _buildMoons(
  //   BuildContext context,
  //   int index,
  //   List<CelestialBody> moons,
  // ) {
  //   List<Widget> _moons = [];
  //   for (var moon in moons)
  //     _moons.add(
  //       ListCell(
  //         leading: HeroImage.list(
  //           url: moon.imageUrl,
  //           tag: moon.id,
  //         ),
  //         title: moon.name,
  //         subtitle: moon.description,
  //         TODO revisar
  //         onTap: () => Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (_) => CelestialBodyPage(
  //                       celestialBody: moon,
  //                       type: BodyType.celestialBody,
  //                     ),
  //               ),
  //             ),
  //       ),
  //     );

  //   if (_moons.isEmpty)
  //     _moons.add(ListTile(
  //       contentPadding: const EdgeInsets.all(8.0),
  //       leading: Icon(Icons.info),
  //       title: Text('No Moons Found'),
  //     ));

  //   return SingleChildScrollView(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: _moons,
  //     ),
  //   );
  // }

  // Widget _buildItem(BuildContext context, int index) {
  //   return Column(
  //     children: <Widget>[
  //       ScopedModelDescendant<PlanetsModel>(
  //         builder: (context, child, model) => ListCell(
  //               leading: HeroImage.list(
  //                 url: model.getItem(index).imageUrl,
  //                 tag: model.getItem(index).id,
  //               ),
  //               title: model.getItem(index).name,
  //               subtitle: model.getItem(index).description,
  //               trailing: IconButton(
  //                 icon: Icon(Icons.arrow_drop_down),
  //                 onPressed: () async {
  //                   var _moons = await model
  //                       .getItem(index)
  //                       .getMoons(model.getItem(index).id);
  //                   showModalBottomSheet<void>(
  //                     context: context,
  //                     builder: (BuildContext context) {
  //                       return SafeArea(
  //                         child: Container(
  //                           child: _buildMoons(context, index, _moons),
  //                         ),
  //                       );
  //                     },
  //                   );
  //                 },
  //               ),
  //               // onTap: () => Navigator.push(
  //               //       context,
  //               //       MaterialPageRoute(
  //               //         builder: (context) => CelestialBodyPage(
  //               //               celestialBody: model.getItem(index),
  //               //               type: BodyType.planet,
  //               //             ),
  //               //       ),
  //               //     ),
  //             ),
  //       ),
  //       const Divider(height: 0.0, indent: 104.0)
  //     ],
  //   );
  // }
}
