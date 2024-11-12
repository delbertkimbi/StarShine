// lib/screens/feed_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/widgets/challenge_card.dart';
import 'package:star_shine/widgets/video_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString activeTab = 'videos'.obs;

    final dummyVideos = [
      {
        'id': '1',
        'title': 'New Hit Single',
        'artist': 'Salatiel',
        'thumbnailUrl': 'data:image/jpeg;base64,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',
        'views': 10000
      },
      {
        'id': '2',
        'title': 'Live Performance',
        'artist': 'Charlotte Dipanda',
        'thumbnailUrl': 'https://example.com/thumbnail2.jpg',
        'views': 5000
      },
      {
        'id': '3',
        'title': 'Music Video',
        'artist': 'Locko',
        'thumbnailUrl': 'https://example.com/thumbnail3.jpg',
        'views': 7500
      },
      {
        'id': '4',
        'title': 'Behind the Scenes',
        'artist': 'Daphne',
        'thumbnailUrl': 'https://example.com/thumbnail4.jpg',
        'views': 3000
      },
    ];

    final dummyChallenges = [
      {
        'id': '1',
        'title': 'Dance Challenge',
        'artist': 'Mr. Leo',
        'thumbnailUrl': 'https://example.com/challenge1.jpg',
        'participants': 500,
        'daysLeft': 3
      },
      {
        'id': '2',
        'title': 'Sing Along Contest',
        'artist': 'Blanche Bailly',
        'thumbnailUrl': 'https://example.com/challenge2.jpg',
        'participants': 300,
        'daysLeft': 5
      },
      {
        'id': '3',
        'title': 'Remix Competition',
        'artist': 'Stanley Enow',
        'thumbnailUrl': 'https://example.com/challenge3.jpg',
        'participants': 200,
        'daysLeft': 7
      },
    ];

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
                views: video['views'] as int,
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
