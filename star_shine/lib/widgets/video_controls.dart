import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// widgets/video_controls.dart
class VideoProgressBar extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoProgressBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      colors: const VideoProgressColors(
        playedColor: Colors.white,
        bufferedColor: Colors.white24,
        backgroundColor: Colors.white12,
      ),
    );
  }
}