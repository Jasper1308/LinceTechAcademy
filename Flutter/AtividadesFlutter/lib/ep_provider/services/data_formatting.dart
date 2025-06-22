import '../models/video_model.dart';

List<String> getHashtags(Video video){
  final List<String> hashtags = video.hashtags.split(',');
  return hashtags;
}

String getVideoId(Video video){
  final List<String> linkSplit = video.url.split('/');
  return linkSplit.last;
}

// Código antigo
// Future<Map<String, dynamic>> getJson(Video video) async {
//   final id = getVideoId(video);
//   final uri = Uri.parse('https://cruiserdev.lince.com.br/video/$id');
//   final response = await http.get(uri);
//   final json = jsonDecode(response.body);
//   return json;
// }

// Future<VideoData> getVideo(Map<String, dynamic> json) async {
//   final videoCompleto = VideoData.fromJson(json);
//   return videoCompleto;
// }