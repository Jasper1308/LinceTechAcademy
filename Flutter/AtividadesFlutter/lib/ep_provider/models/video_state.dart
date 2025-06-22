import 'package:ap1/ep_provider/controller/database.dart';
import 'package:flutter/material.dart';
import '../services/data_formatting.dart';
import '../services/youtube_api.dart';
import 'video_model.dart';

class VideoState with ChangeNotifier{
  final List<VideoData> _listVideos = [];

  List<VideoData> get videos => List.unmodifiable(_listVideos);

  Future<void> addVideo(Video video) async {
    final id = getVideoId(video);
    final hashs = getHashtags(video);
    final json = await YouTubeAPI.fetchVideoData(id);
    final videoData = VideoData(
      title: json['title'] ?? '',
      thumbnail: json['thumbnail_url'] ?? '',
      channelName: json['author_name'] ?? '',
      channelURL: json['author_url'] ?? '',
      hashtags: hashs,
    );
    _listVideos.add(videoData);
    VideoController().save(videoData);
    notifyListeners();
  }

  Future<void> listVideos() async {
    final list = await VideoController().listVideos();
    _listVideos.addAll(list);
    notifyListeners();
  }

  Future<void> deleteVideo(VideoData video) async {
    _listVideos.remove(video);
    await VideoController().delete(video);
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