// lib/screens/user_signup.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/controllers/auth_controller.dart';
import 'package:star_shine/screens/favourite_artist.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    // final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login to your account',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2F2F2F),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Join ${AppConstants.appName} and discover amazing Cameroonian music',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black38,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Add social login section
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.google,
                size: 18,
                color: Color(0xFFFFA726),
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                    color: Color(0xFFFFA726), fontWeight: FontWeight.w500),
              ),
            ).animate().slideX(duration: 400.ms, begin: -0.2),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ).animate().fadeIn(duration: 500.ms),

            const SizedBox(height: 24),
            // Email field with animation
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFFFFA726),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFFFFA726), width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ).animate().slideX(duration: 400.ms, begin: 0.2),

            const SizedBox(height: 16),
            // Password field with animation
            Obx(() => TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFFFFA726),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        authController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFFFA726),
                      ),
                      onPressed: () =>
                          authController.togglePasswordVisibility(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFFFFA726), width: 2),
                    ),
                  ),
                  obscureText: !authController.isPasswordVisible.value,
                )).animate().slideX(duration: 400.ms, begin: -0.2),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed('/forgot-password'),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFFFFA726)),
                ),
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                authController.setUserType(false);
                authController.login();
                Get.to(() => const FavoriteArtists());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                shadowColor: const Color(0xFFFFA726).withOpacity(0.5),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms).scale(delay: 200.ms),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/user-registration');
                    },
                    child: const Text(
                      "Create One",
                      style: TextStyle(
                        color: Color(0xFFFFA726),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
