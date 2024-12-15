class MetadataModel {
  final String platformName;
  final String title;
  final String thumbnailUrl;

  MetadataModel({
    required this.platformName,
    required this.title,
    required this.thumbnailUrl,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      platformName: json['site_name'] ?? 'Unknown',
      title: json['title'] ?? 'No Title',
      thumbnailUrl: json['image'] ?? '',
    );
  }
}
