import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:star_shine/widgets/action_sidebar.dart';
import 'package:star_shine/widgets/long_press_menu.dart';
import 'package:star_shine/widgets/lyrics_overlay.dart';
import 'package:star_shine/widgets/next_video_suggestion.dart';
import 'package:star_shine/widgets/user_profile_overlay.dart';
import 'package:star_shine/widgets/video_controls.dart';
import 'package:video_player/video_player.dart';

enum VideoSourceType {
  asset,
  file,
}

class VideoData {
  final String path;
  final VideoSourceType sourceType;
  final String title;
  VideoPlayerController? controller;
  bool isInitialized = false;

  VideoData({
    required this.path,
    required this.sourceType,
    required this.title,
  });

  Future<VideoPlayerController> initializeController() async {
    switch (sourceType) {
      case VideoSourceType.asset:
        return VideoPlayerController.asset(path);
      case VideoSourceType.file:
        return VideoPlayerController.file(File(path));
    }
  }
}

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key, required String videoId});

  @override
  _ShortsScreenState createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  late PageController _pageController;
  bool _isLongPressMenuVisible = false;
  bool _isLyricsVisible = false;
  bool _showNextVideoSuggestion = false;
  Timer? _longPressTimer;
  int _currentPageIndex = 0;
  bool _isPlaying = true;

  // List of video data combining assets and local files
  final List<VideoData> _videos = [
    // Videos from assets
    VideoData(
      path: 'assets/videos/ko.mp4',
      sourceType: VideoSourceType.asset,
      title: 'Ko C',
    ),
    VideoData(
      path: 'assets/videos/video2.mp4',
      sourceType: VideoSourceType.asset,
      title: 'Asset Video 2',
    ),
    // Videos from local storage
    VideoData(
      path: '/storage/emulated/0/DCIM/Camera/video1.mp4', // Android path example
      sourceType: VideoSourceType.file,
      title: 'Local Video 1',
    ),
    VideoData(
      path: '/Users/username/Videos/video2.mp4', // iOS/desktop path example
      sourceType: VideoSourceType.file,
      title: 'Local Video 2',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeCurrentVideo();
  }

  Future<void> _initializeCurrentVideo() async {
    final currentVideo = _videos[_currentPageIndex];
    if (currentVideo.controller == null) {
      try {
        currentVideo.controller = await currentVideo.initializeController();
        await currentVideo.controller!.initialize();

        if (mounted) {
          setState(() {
            currentVideo.isInitialized = true;
          });
          currentVideo.controller?.play();
          _setupVideoListeners(currentVideo.controller!);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error initializing video: $e');
        }
        // Handle error - maybe show error state or skip to next video
        if (mounted) {
          setState(() {
            currentVideo.isInitialized = false;
          });
        }
      }
    }

    // Pre-initialize the next video
    if (_currentPageIndex < _videos.length - 1) {
      final nextVideo = _videos[_currentPageIndex + 1];
      if (nextVideo.controller == null) {
        try {
          nextVideo.controller = await nextVideo.initializeController();
          await nextVideo.controller!.initialize();
        } catch (e) {
          if (kDebugMode) {
            print('Error pre-initializing next video: $e');
          }
        }
      }
    }
  }

  void _setupVideoListeners(VideoPlayerController controller) {
    controller.addListener(() {
      if (!mounted) return;

      final Duration position = controller.value.position;
      final Duration duration = controller.value.duration;

      if (duration.inSeconds - position.inSeconds <= 3 && !_showNextVideoSuggestion) {
        setState(() {
          _showNextVideoSuggestion = true;
        });
      }
    });
  }

  Future<void> _onPageChanged(int index) async {
    // Pause the previous video
    if (_currentPageIndex < _videos.length) {
      _videos[_currentPageIndex].controller?.pause();
    }

    setState(() {
      _currentPageIndex = index;
      _isPlaying = true;
      _showNextVideoSuggestion = false;
    });

    // Initialize and play the current video
    await _initializeCurrentVideo();
    _videos[_currentPageIndex].controller?.play();

    // Cleanup old videos
    if (index > 1) {
      _videos[index - 2].controller?.dispose();
      _videos[index - 2].controller = null;
      _videos[index - 2].isInitialized = false;
    }
  }

  void _togglePlayPause() {
    final currentVideo = _videos[_currentPageIndex];
    if (currentVideo.controller != null && currentVideo.isInitialized) {
      setState(() {
        _isPlaying = !_isPlaying;
        if (_isPlaying) {
          currentVideo.controller?.play();
        } else {
          currentVideo.controller?.pause();
        }
      });
    }
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
        onTap: _togglePlayPause,
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return Stack(
                  children: [
                    if (video.controller != null && video.isInitialized)
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: video.controller!.value.size.width,
                            height: video.controller!.value.size.height,
                            child: VideoPlayer(video.controller!),
                          ),
                        ),
                      ),

                    // Loading indicator
                    if (!video.isInitialized)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),

                    // Play/Pause Indicator
                    if (!_isPlaying && video.isInitialized)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),

                    // Error indicator
                    if (!video.isInitialized && video.controller?.value.hasError == true)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Error loading video',
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          ],
                        ),
                      ),

                    if (video.isInitialized)
                      Positioned(
                        bottom: 85,
                        left: 0,
                        right: 0,
                        child: VideoProgressBar(controller: video.controller!),
                      ),

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

                    const Positioned(
                      left: 8,
                      bottom: 20,
                      child: UserProfileOverlay(),
                    ),

                    if (_isLyricsVisible)
                      const LyricsOverlay(),

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
    for (var video in _videos) {
      video.controller?.dispose();
    }
    _pageController.dispose();
    _longPressTimer?.cancel();
    super.dispose();
  }
}