class Video {
  final String url;
  final String hashtags;

  const Video({required this.url, required this.hashtags});
}

class VideoData{
  final String title;
  final String thumbnail;
  final String channelName;
  final String channelURL;
  final List<String> hashtags = [];

  VideoData({
    required this.title,
    required this.thumbnail,
    required this.channelName,
    required this.channelURL,
  });


  // VideoCompleto.fromJson(Map<String, dynamic> json)
  //   : titulo = json['titulo'],
  //     canal = Canal.fromJson(json['canal']),
  //     imagem = json['imagem'];
}

// class Canal {
//   final String nome;
//   final String url;
//
//   Canal.fromJson(Map<String, dynamic> json)
//     : nome = json['nome'],
//       url = json['url'];
// }
