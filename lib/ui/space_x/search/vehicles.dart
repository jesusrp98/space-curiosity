import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:material_search/material_search.dart';
import 'package:space_news/ui/space_x/details/capsule.dart';
import 'package:space_news/ui/space_x/details/roadster.dart';
import 'package:space_news/ui/space_x/details/rocket.dart';
import 'package:space_news/ui/space_x/details/ship.dart';

import '../../../models/rockets/info_vehicle.dart';


/// SEARCH VEHICLES METHOD
/// Auxiliary method which helps filter vehicles by its name
searchVehicles(BuildContext context, List list) {
  return MaterialPageRoute<Vehicle>(
    builder: (context) => Material(
          child: MaterialSearch<Vehicle>(
            barBackgroundColor: Theme.of(context).primaryColor,
            iconColor: Colors.white,
            placeholder: FlutterI18n.translate(
              context,
              'spacex.other.tooltip.search',
            ),
            limit: list.length,
            results: list
                .map((item) => MaterialSearchResult<Vehicle>(
                      icon: Icons.search,
                      value: item,
                      text: item.name,
                    ))
                .toList(),
            filter: (dynamic value, String criteria) => value.name
                .toLowerCase()
                .trim()
                .contains(RegExp(r'' + criteria.toLowerCase().trim() + '')),
            onSelect: (dynamic vehicle) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => vehicle.type == 'rocket'
                        ? RocketPage(vehicle)
                        : vehicle.type == 'capsule'
                            ? CapsulePage(vehicle)
                            : vehicle.type == 'ship'
                                ? ShipPage(vehicle)
                                : RoadsterPage(vehicle),
                  ),
                ),
          ),
        ),
  );
}
