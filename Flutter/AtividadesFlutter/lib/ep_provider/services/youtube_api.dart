import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/video_model.dart';

const _urlTemplate =
    'https://www.youtube.com/oembed?format=json&url=http://www.youtube.com/watch?v=';

class FailedRequestException implements Exception {
  FailedRequestException(this.videoID);

  final String videoID;

  @override
  String toString() {
    return '[FailedRequestException] Failed to load video $videoID';
  }
}

class YouTubeAPI {
  static Future<Map<String, dynamic>> fetchVideoData(String videoID, ) async {
    final response = await http.get(Uri.parse('$_urlTemplate$videoID'));
    if (response.statusCode != 200) {
      throw FailedRequestException(videoID);
    }
    final decoded = jsonDecode(response.body);
    return decoded;
    // return VideoData(
    //   title: decoded['title'] ?? '',
    //   thumbnail: decoded['thumbnail_url'] ?? '',
    //   channelName: decoded['author_name'] ?? '',
    //   channelURL: decoded['author_url'] ?? '',
    // );
  }
}
