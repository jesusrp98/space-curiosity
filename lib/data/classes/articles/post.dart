import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webfeed/domain/rss_item.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  Post({
    this.author,
    this.photo,
    this.title,
    this.url,
  }) : super([url, photo, title, photo]);

  final String title, author, url, photo;

  @override
  String toString() =>
      'Post { Title: $title, Author: $author, Photo: $photo, Url: $url }';

  String get getTitle => title.trimRight();

  factory Post.fromRss(RssItem item) {
    return Post(
      title: item.title,
      author: item.author,
      url: item.link,
      photo: item.enclosure.url,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
