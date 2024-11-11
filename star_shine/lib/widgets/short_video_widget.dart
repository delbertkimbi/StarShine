import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortVideoData {
  final String videoUrl;
  final String thumbnailUrl;
  final String title;
  final String artist;

  ShortVideoData({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
    required this.artist,
  });
}

class ShortVideoWidget extends StatefulWidget {
  final ShortVideoData videoData;

  const ShortVideoWidget({
    super.key,
    required this.videoData,
  });

  @override
  _ShortVideoWidgetState createState() => _ShortVideoWidgetState();
}

class _ShortVideoWidgetState extends State<ShortVideoWidget> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoData.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _videoPlayerController.value.isInitialized
            ? AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        )
            : Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.videoData.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.videoData.artist,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}