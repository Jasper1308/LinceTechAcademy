import 'package:flutter/material.dart';

import '../models/video_model.dart';

class VideoCard extends StatefulWidget {
  final VideoData video;
  const VideoCard({super.key, required this.video});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image(
              image: NetworkImage(widget.video.thumbnail),
              height: 100.0,
              width: 150.0,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.video.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.video.channelName,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // Text(
                //   widget.video.hashtags
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}