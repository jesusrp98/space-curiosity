import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

import '../../../models/rockets/launch.dart';
import '../../../util/colors.dart';
import 'page_launch.dart';

searchLaunches(BuildContext context, List list) {
  return MaterialPageRoute<Launch>(
    builder: (context) {
      return Material(
        child: MaterialSearch<Launch>(
          barBackgroundColor: primaryColor,
          iconColor: Colors.white,
          placeholder: 'Search',
<<<<<<< HEAD
          limit: list.length,
=======
          limit: 100,
>>>>>>> Initial implementation of search
          results: list
              .map((v) => MaterialSearchResult<Launch>(
                    icon: Icons.person,
                    value: v,
                    text: v.name,
                  ))
              .toList(),
          filter: (dynamic value, String criteria) {
            return (value as Launch)
                .name
                .toLowerCase()
                .trim()
                .contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
          },
          onSelect: (dynamic launch) => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LaunchPage(launch)),
              ),
        ),
      );
    },
  );
}
