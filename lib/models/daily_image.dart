class ImageData {
  final String title, date, url, hdurl, description;
  ImageData({
    this.date,
    this.description,
    this.hdurl,
    this.title,
    this.url,
  });

  factory ImageData.fromJson(Map json) {
    return ImageData(
      title: json['title'],
      date: json['date'],
      description: json['explanation'],
      hdurl: json['hdurl'],
      url: json['url'],
    );
  }
}
