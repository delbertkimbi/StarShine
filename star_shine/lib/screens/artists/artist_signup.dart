// lib/screens/artist_signup.dart
import /**/ 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/controllers/auth_controller.dart';

class ArtistSignUp extends StatelessWidget {
  const ArtistSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    // final TextEditingController genreController = TextEditingController();
    // final TextEditingController bioController = TextEditingController();
    // final TextEditingController locationController = TextEditingController();
    // final TextEditingController websiteController = TextEditingController();
    final TextEditingController socialMediaController = TextEditingController();

    final List<String> musicGenres = [
      'Makossa',
      'Bikutsi',
      'Afrobeat',
      'Amapiano',
      'Ndombolo',
      'Afropop',
      'Afro-jazz',
      'Bendskin',
      'Highlife',
      'Gospel',
      'Soukous',
      'Hiplife',
      'Reggae',
      'Hip Hop',
      'R&B'
    ];
    String selectedGenre = musicGenres[0];

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
              'Join ${AppConstants.appName} and connect with your Fans',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4ECDC4),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 18,
                    child: const Icon(Icons.camera_alt, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
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
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedGenre,
              decoration: InputDecoration(
                labelText: 'Primary Genre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              items: musicGenres.map((String genre) {
                return DropdownMenuItem(
                  value: genre,
                  child: Text(genre),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedGenre = newValue;
                }
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: socialMediaController,
              decoration: InputDecoration(
                labelText: 'Social Media Links',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                authController.setUserType(true);
                authController.login();
                Get.offAllNamed('/artist-home');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.black87),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/artist-login');
                  },
                  child: const Text('Log in'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
