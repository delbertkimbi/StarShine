import 'dart:async';

import 'package:flutter/material.dart';
import 'package:star_shine/widgets/action_sidebar.dart';
import 'package:star_shine/widgets/long_press_menu.dart';
import 'package:star_shine/widgets/lyrics_overlay.dart';
import 'package:star_shine/widgets/next_video_suggestion.dart';
import 'package:star_shine/widgets/user_profile_overlay.dart';
import 'package:star_shine/widgets/video_controls.dart';
import 'package:video_player/video_player.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  _ShortsScreenState createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  late PageController _pageController;
  late VideoPlayerController _videoController;
  bool _isLongPressMenuVisible = false;
  bool _isLyricsVisible = false;
  bool _showNextVideoSuggestion = false;
  Timer? _longPressTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeVideo();
  }

  void _initializeVideo() {
    // Initialize with dummy video URL - replace with actual video
    _videoController = VideoPlayerController.network(
      'file:///Users/funwikelseandohnwi/Downloads/Alicia%20Keys%20-%20Try%20Sleeping%20with%20a%20Broken%20Heart%20(Official%20Video).mp4',
    )..initialize().then((_) {
      setState(() {});
      _videoController.play();
      _setupVideoListeners();
    });
  }

  void _setupVideoListeners() {
    _videoController.addListener(() {
      final Duration position = _videoController.value.position;
      final Duration duration = _videoController.value.duration;

      // Show next video suggestion when current video is almost complete
      if (duration.inSeconds - position.inSeconds <= 3 && !_showNextVideoSuggestion) {
        setState(() {
          _showNextVideoSuggestion = true;
        });
      }
    });
  }

  void _startLongPress() {
    _longPressTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLongPressMenuVisible = true;
      });
    });
  }

  void _endLongPress() {
    _longPressTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onLongPressStart: (_) => _startLongPress(),
        onLongPressEnd: (_) => _endLongPress(),
        child: Stack(
          children: [
            // Video PageView
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // Video Player
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      ),
                    ),

                    // Video Progress Bar
                    Positioned(
                      bottom: 85,
                      left: 0,
                      right: 0,
                      child: VideoProgressBar(controller: _videoController),
                    ),

                    // Action Sidebar
                    Positioned(
                      right: 8,
                      bottom: 100,
                      child: ActionSidebar(
                        onLyricsPressed: () {
                          setState(() {
                            _isLyricsVisible = !_isLyricsVisible;
                          });
                        },
                      ),
                    ),

                    // User Profile Overlay
                    const Positioned(
                      left: 8,
                      bottom: 20,
                      child: UserProfileOverlay(),
                    ),

                    // Lyrics Overlay (if visible)
                    if (_isLyricsVisible)
                      const LyricsOverlay(),

                    // Next Video Suggestion
                    if (_showNextVideoSuggestion)
                      NextVideoSuggestion(
                        onDismiss: () {
                          setState(() {
                            _showNextVideoSuggestion = false;
                          });
                        },
                      ),
                  ],
                );
              },
            ),

            // Long Press Menu
            if (_isLongPressMenuVisible)
              LongPressMenu(
                onClose: () {
                  setState(() {
                    _isLongPressMenuVisible = false;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pageController.dispose();
    _longPressTimer?.cancel();
    super.dispose();
  }
}

