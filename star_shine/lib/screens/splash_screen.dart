// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:star_shine/screens/usertype_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const UserTypeSelectionScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            SizedBox(
              width: 150, // Increased size
              height: 150,
              child: Stack(
                children: [
                  // Outer rotating ring
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.orange.shade400,
                        width: 4,
                      ),
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .rotate(duration: const Duration(seconds: 3))
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.1, 1.1),
                        duration: const Duration(seconds: 1),
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.1, 1.1),
                        end: const Offset(0.8, 0.8),
                        duration: const Duration(seconds: 1),
                      ),

                  // Middle rotating ring
                  Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.orange.shade300,
                        width: 3,
                      ),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat()).rotate(
                        duration: const Duration(seconds: 3),
                        begin: 0,
                        end: -1,
                      ),

                  // Center gradient circle
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.shade200.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.orange.shade400,
                            Colors.orange.shade300,
                            Colors.orange.shade200,
                          ],
                        ),
                      ),
                    ),
                  ).animate().scale(
                        duration: 800.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                      ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // App Name
            Text(
              'Pablow',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    letterSpacing: 1.5,
                  ),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad)
                .scale(begin: const Offset(0.5, 0.5)),

            const SizedBox(height: 16),

            // Tagline
            Text(
              'Ride the wave of Cameroonian music',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad)
                .scale(begin: const Offset(0.5, 0.5)),
          ],
        ),
      ),
    );
  }
}
