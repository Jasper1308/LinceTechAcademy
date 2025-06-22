import 'package:flutter/material.dart';
import '../services/data_formatting.dart';
import '../services/youtube_api.dart';
import 'video_model.dart';

class VideoState with ChangeNotifier{
  final List<VideoData> _listVideos = [];

  List<VideoData> get videos => List.unmodifiable(_listVideos);

  Future<void> addVideo(Video video) async {
    _listVideos.add(await YouTubeAPI.fetchVideoData(getVideoId(video)));
    notifyListeners();
}


  // Código antigo
  // Future<void> addVideo(Video video) async {
  //   final json = await getJson(video);
  //   final VideoData videoCompleto = await getVideo(json);
  //   _listVideos.add(videoCompleto);
  //   notifyListeners();
  // }
}