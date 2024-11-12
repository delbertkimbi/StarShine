import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/controllers/auth_controller.dart';
import 'package:star_shine/game/game_screen.dart';
import 'package:star_shine/screens/artists/artist_show.dart';
import 'package:star_shine/screens/feed_screen.dart';
import 'package:star_shine/screens/profile_screen.dart';
import 'package:star_shine/screens/shorts_screen.dart';
import 'package:star_shine/screens/upload_profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final RxInt currentIndex = 0.obs;

    final screens = [
      const FeedScreen(),
      const ShortsScreen(videoId: '',),
      const GameScreen(),
      ArtistScreen(),
      if (authController.isArtist) const UploadScreen(),
      const ArtistProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: currentIndex.value,
        children: screens,
      )),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(
              color: Colors.black,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        child: Obx(() => BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (index) {
            currentIndex.value = index;
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Feed',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              label: 'Shorts',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              label: 'Games',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            if (authController.isArtist)
              const BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Upload',
              ),
          ],
        )),
      ),
    );
  }
}