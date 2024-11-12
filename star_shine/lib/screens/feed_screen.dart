// lib/screens/feed_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/screens/shorts_screen.dart';
import 'package:star_shine/widgets/challenge_card.dart';
import 'package:star_shine/widgets/video_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString activeTab = 'videos'.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Obx(() => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => activeTab.value = 'videos',
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: activeTab.value == 'videos'
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Videos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: activeTab.value == 'videos'
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => activeTab.value = 'challenges',
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: activeTab.value == 'challenges'
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Challenges',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: activeTab.value == 'challenges'
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: Obx(() {
        if (activeTab.value == 'videos') {
          return ListView.builder(
            itemCount: dummyVideos.length,
            itemBuilder: (context, index) {
              final video = dummyVideos[index];
              return VideoCard(
                title: video['title'] as String,
                artist: video['artist'] as String,
                thumbnailUrl: video['thumbnailUrl'] as String,
                views: 1500000,
                likes: 250000,
                description: 'Watch this incredible dance performance as the sun sets over the ocean. Featuring world-class dancers and breathtaking choreography that will leave you speechless! 🌅💃',
                uploadDate: DateTime.now().subtract(const Duration(days: 2)),
                duration: const Duration(minutes: 2, seconds: 45),
                onTap: () {
                  // Navigate to shorts screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShortsScreen(videoId: 'your_video_id'),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return ListView.builder(
            itemCount: dummyChallenges.length,
            itemBuilder: (context, index) {
              final challenge = dummyChallenges[index];
              return ChallengeCard(
                title: challenge['title'] as String,
                artist: challenge['artist'] as String,
                thumbnailUrl: challenge['thumbnailUrl'] as String,
                participants: challenge['participants'] as int,
                daysLeft: challenge['daysLeft'] as int,
              );
            },
          );
        }
      }),
    );
  }
}
