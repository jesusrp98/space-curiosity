import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String date;
  final String url;

  Post({
    this.id,
    this.title,
    this.body,
    this.date,
    this.url,
  }) : super([id, title, body, date, url]);

  @override
  String toString() => 'Post { id: $id }';
}
