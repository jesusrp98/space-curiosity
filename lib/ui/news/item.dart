import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../models/models.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        title: Text(post.title),
        subtitle: Text(post.body + "\n\n" + post.date),
        onTap: () async => await FlutterWebBrowser.openWebPage(
              url: post.url,
              androidToolbarColor: Theme.of(context).brightness,
            ),
      ),
    );
  }
}
