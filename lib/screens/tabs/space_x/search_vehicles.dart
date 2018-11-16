import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:space_news/util/colors.dart';

import '../../../models/rockets/vehicle.dart';
import 'page_capsule.dart';
import 'page_roadster.dart';
import 'page_rocket.dart';
import 'page_ship.dart';

searchVehicles(BuildContext context, List list) {
  return MaterialPageRoute<Vehicle>(
    builder: (context) {
      return Material(
        child: MaterialSearch<Vehicle>(
          barBackgroundColor: primaryColor,
          iconColor: Colors.white,
          placeholder: 'Search',
          limit: list.length,
          results: list
              .map((v) => MaterialSearchResult<Vehicle>(
                    icon: Icons.person,
                    value: v,
                    text: v.name,
                  ))
              .toList(),
          filter: (dynamic value, String criteria) {
            return value.name
                .toLowerCase()
                .trim()
                .contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
          },
          onSelect: (dynamic vehicle) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => (vehicle.type == 'rocket')
                      ? RocketPage(vehicle)
                      : (vehicle.type == 'capsule')
                          ? CapsulePage(vehicle)
                          : (vehicle.type == 'ship')
                              ? ShipPage(vehicle)
                              : RoadsterPage(vehicle),
                ),
              ),
        ),
      );
    },
  );
}
