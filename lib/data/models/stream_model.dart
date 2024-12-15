class StreamModel {
  final String platform;
  final String title;
  final String url;
  final String thumbnail;

  StreamModel({
    required this.platform,
    required this.title,
    required this.url,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'title': title,
      'url': url,
      'thumbnail': thumbnail,
    };
  }

  factory StreamModel.fromMap(Map<String, dynamic> map) {
    return StreamModel(
      platform: map['platform'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
    );
  }
}
