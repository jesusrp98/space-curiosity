import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'row_item.dart';

class DialogListTile extends StatelessWidget {
  final String title;
  final int id;
  final ScopedModel screen;

  DialogListTile({this.title, this.id, this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: RowItem.textRow(title, '#$id'),
      ),
    );
  }
}
