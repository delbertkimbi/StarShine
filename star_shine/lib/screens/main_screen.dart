// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/controllers/auth_controller.dart';
import 'package:star_shine/screens/feed_screen.dart';
import 'package:star_shine/screens/profile_screen.dart';
import 'package:star_shine/screens/upload_profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final RxInt currentIndex = 0.obs;

    final screens = [
      const FeedScreen(),
      if (authController.isArtist) const UploadScreen(),
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
          if (authController.isArtist)
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Upload',
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