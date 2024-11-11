// lib/screens/artist_landing.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:star_shine/screens/artist_signup.dart';
import 'package:star_shine/screens/user_signup.dart';
import 'package:star_shine/widgets/feature_card.dart';

class ArtistLanding extends StatelessWidget {
  const ArtistLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MelodiWave'),
        actions: [
          TextButton.icon(
            onPressed: () => Get.to(() => const ArtistSignUp()),
            icon: const Icon(Icons.person_add, size: 16),
            label: const Text('Sign Up'),
          ),
          TextButton.icon(
            onPressed: () {}, // TODO: Implement login
            icon: const Icon(Icons.login, size: 16),
            label: const Text('Log In'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Amplify Your Music Career',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2F2F2F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Join MelodiWave and connect with fans, boost your visibility, and monetize your talent.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const FeatureCard(
                icon: Icons.people,
                title: 'Grow Your Fan Base',
                description: 'Engage with your audience through challenges and live streams. Build a loyal community around your music.',
                color: Colors.black87,
              ),
              const SizedBox(height: 16),
              const FeatureCard(
                icon: Icons.visibility,
                title: 'Boost Your Visibility',
                description: 'Get discovered by new listeners. Our platform promotes Cameroonian talent to a wider audience.',
                color: Colors.black54,
              ),
              const SizedBox(height: 16),
              const FeatureCard(
                icon: Icons.monetization_on,
                title: 'Monetize Your Talent',
                description: 'Turn your passion into profit. Create paid challenges, receive tips, and unlock new revenue streams.',
                color: Colors.black38,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Get.to(() => const UserSignUp()),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Join MelodiWave Today'),
                    SizedBox(width: 8),
                    Icon(Icons.music_note, size: 16),
                  ],
                ),
              ).animate()
                .fadeIn(duration: 300.ms)
                .shimmer(delay: 300.ms, duration: 1800.ms),
            ],
          ),
        ),
      ),
    );
  }
}