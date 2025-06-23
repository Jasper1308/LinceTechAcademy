import 'package:ap1/ep_provider/models/color_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_state.dart';
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
    final colorState = Provider.of<ColorState>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: colorState.cardColor.color,
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.video.thumbnail),
              height: 200,
              width: double.infinity,
            ),
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
            Text(
              widget.video.hashtags.join(', '),
            ),
          ],
        ),
      ),
    );
  }
}