
// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen - Coming Soon'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                authController.logout();
                Get.offAllNamed('/'); // Navigate to the splash screen
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}