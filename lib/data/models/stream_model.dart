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

  // Convert StreamModel to Map (useful for saving to a database or JSON)
  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'title': title,
      'url': url,
      'thumbnail': thumbnail,
    };
  }

  // Create a StreamModel from a Map (useful for loading from a database or JSON)
  factory StreamModel.fromMap(Map<String, dynamic> map) {
    return StreamModel(
      platform: map['platform'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
    );
  }
}
