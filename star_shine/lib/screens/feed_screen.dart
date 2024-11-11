// lib/screens/feed_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        'thumbnailUrl': 'https://example.com/thumbnail1.jpg',
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
        title: const Text('MelodiWave'),
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
