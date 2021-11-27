class ImageResult {
  late int position;
  late String thumbnail;
  late String source;
  late String title;
  late String link;
  late String original;

  ImageResult({
    required this.position,
    required this.thumbnail,
    required this.source,
    required this.title,
    required this.link,
    required this.original,
  });

  factory ImageResult.fromMap(Map<String, dynamic> json) {
    return ImageResult(
      position: json['position'],
      thumbnail: json['thumbnail'],
      source: json['source'],
      title: json['title'],
      link: json['link'],
      original: json['original'],
    );
  }
}
