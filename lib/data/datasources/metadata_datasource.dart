import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/metadata_model.dart';

class MetadataDataSource {
  static const String _apiKey =
      '3572d5af9de75b136e2dc4807908bfef'; // Replace with your LinkPreview API Key
  static const String _apiBaseUrl = 'https://api.linkpreview.net';

  static Future<MetadataModel> fetchMetadata(String url) async {
    final apiUrl = '$_apiBaseUrl?key=$_apiKey&q=$url';
    print('Fetching metadata from: $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return MetadataModel(
          title: data['title'] ?? 'No Title',
          thumbnailUrl: data['image'] ?? '',
          platformName: _determinePlatform(url),
        );
      } else {
        print('Error fetching metadata: ${response.statusCode}');
        throw Exception('Failed to fetch metadata');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to fetch metadata');
    }
  }

  static String _determinePlatform(String url) {
    if (url.contains('youtube.com') || url.contains('youtu.be')) {
      return 'YouTube';
    } else if (url.contains('twitch.tv')) {
      return 'Twitch';
    } else if (url.contains('facebook.com')) {
      return 'Facebook';
    }
    return 'Unknown';
  }
}
