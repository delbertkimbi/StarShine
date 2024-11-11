import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/controllers/auth_controller.dart';
import 'package:star_shine/screens/artists/artist_show.dart';
import 'package:star_shine/screens/artists/follower_screen.dart';
import 'package:star_shine/screens/feed_screen.dart';
import 'package:star_shine/screens/profile_screen.dart';
import 'package:star_shine/screens/upload_profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final RxInt currentIndex = 0.obs;

    // Screens to display in the main view
    final screens = [
      const FeedScreen(),
      const ArtistsScreen(), // New: All Artists screen
      if (authController.isArtist) const UploadScreen(),
      const FollowersScreen(), // New: Followers screen
      const ArtistProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: currentIndex.value,
        children: screens,
      )), 
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Artists',
          ),
          if (authController.isArtist)
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Upload',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Followers',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
