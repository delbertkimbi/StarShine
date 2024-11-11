// lib/screens/artist_signup.dart
import /**/'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/controllers/auth_controller.dart';
import 'package:star_shine/screens/main_screen.dart';
class ArtistSignUp extends StatelessWidget {
  const ArtistSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController genreController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Artist Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create your artist account',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2F2F2F),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Join MelodiWave and connect with your fans',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Artist/Band Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: 'Primary Genre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                authController.setUserType(true);
                authController.login();
                Get.offAll(() => const MainScreen());
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Navigate to login screen
              },
              child: const Text('Already have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}