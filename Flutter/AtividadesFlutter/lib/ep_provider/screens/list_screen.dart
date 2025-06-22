import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/video_card.dart';
import '../models/color_state.dart';
import '../models/video_state.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({super.key});

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {


  @override
  Widget build(BuildContext context) {
    final colorState = Provider.of<ColorState>(context, listen: false);
    return Scaffold(
      backgroundColor: colorState.backgroundColor,
      appBar: AppBar(
        backgroundColor: colorState.appBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => print('settings'),
              icon: Icon(Icons.search),
            ),
            SizedBox(height: 8,),
            Text('Favoritos YT'),
            SizedBox(height: 8),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/preferences'),
                icon: Icon(Icons.settings)
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<VideoState>(
              builder: (context, state, child){
                final videos = state.videos;

                if(videos.isEmpty){
                  return Center(
                    child: Text('Nenhum vídeo cadastrado'),
                  );
                }

                return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int i) => VideoCard(video: videos[i]));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
