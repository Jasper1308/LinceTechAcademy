import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/video_model.dart';

Future<Database> getDatabase() async{
  final dbPath = join(
    await getDatabasesPath(),
    'videos.db'
  );
  return openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version){
      db.execute(TabelaVideos.createTable);
    }
  );
}

class TabelaVideos {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $title TEXT PRIMARY KEY NOT NULL,
      $thumbnail TEXT NOT NULL,
      $channelName TEXT NOT NULL,
      $channelURL TEXT NOT NULL,
      $hashtags TEXT NOT NULL
    );
  ''';

  static const String tableName = 'videos';
  static const String title = 'title';
  static const String thumbnail = 'thumbnail';
  static const String channelName = 'channelName';
  static const String channelURL = 'channelURL';
  static const String hashtags = 'hashtags';

  static Map<String, dynamic> toMap(VideoData video){
    return {
      title: video.title,
      thumbnail: video.thumbnail,
      channelName: video.channelName,
      channelURL: video.channelURL,
      hashtags: video.hashtags.join(','),
    };
  }
}

class VideoController {
  Future<void> save(VideoData video) async {
    final db = await getDatabase();
    final map = TabelaVideos.toMap(video);
    await db.insert(TabelaVideos.tableName, map);
  }

  Future<List<VideoData>> listVideos() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
        TabelaVideos.tableName);
    var list = <VideoData>[];
    for (final item in result) {
      list.add(
          VideoData(
            title: item[TabelaVideos.title],
            thumbnail: item[TabelaVideos.thumbnail],
            channelName: item[TabelaVideos.channelName],
            channelURL: item[TabelaVideos.channelURL],
            hashtags: item[TabelaVideos.hashtags].split(','),
          )
      );
    }
    return list;
  }

  Future<void> delete(VideoData video) async {
    final db = await getDatabase();
    await db.delete(
      TabelaVideos.tableName,
      where: '${TabelaVideos.title} = ?',
      whereArgs: [video.title],
    );
  }
}