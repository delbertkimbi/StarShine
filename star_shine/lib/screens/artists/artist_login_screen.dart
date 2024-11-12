import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/controllers/auth_controller.dart';
import 'package:star_shine/screens/artists/artist_signup.dart';
import 'package:flutter/services.dart';

class ArtistLogin extends StatefulWidget {
  const ArtistLogin({super.key});

  @override
  State<ArtistLogin> createState() => _ArtistLoginState();
}

class _ArtistLoginState extends State<ArtistLogin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<Offset>> _itemSlideAnimations;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    // Create individual animations for each list item
    _itemSlideAnimations = List.generate(
      4, // Number of animated items
      (index) => Tween<Offset>(
        begin: const Offset(0.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2 + (index * 0.1), // Stagger the animations
          0.7 + (index * 0.1),
          curve: Curves.easeOutCubic,
        ),
      )),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFA726).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  // Animated Welcome Text
                  SlideTransition(
                    position: _itemSlideAnimations[0],
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Welcome Back Artist!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2F2F2F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Animated Email Field
                  SlideTransition(
                    position: _itemSlideAnimations[1],
                    child: _buildAnimatedTextField(
                      controller: emailController,
                      label: 'Email address',
                      icon: Icons.email,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Animated Password Field
                  SlideTransition(
                    position: _itemSlideAnimations[2],
                    child: _buildAnimatedTextField(
                      controller: passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Animated Login Button
                  SlideTransition(
                    position: _itemSlideAnimations[3],
                    child: _buildAnimatedButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFA726).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFFFA726), width: 1),
                ),
                prefixIcon: Icon(icon, color: const Color(0xFFFFA726)),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFA726).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Add a micro-interaction animation here
                HapticFeedback.mediumImpact();
                authController.setUserType(true);
                authController.login();
                Get.offAllNamed('/artist-home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
