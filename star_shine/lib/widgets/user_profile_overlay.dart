import 'package:flutter/material.dart';

// widgets/user_profile_overlay.dart
class UserProfileOverlay extends StatelessWidget {
  const UserProfileOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
          // Add profile image here
        ),
        SizedBox(width: 8),
        Text(
          '@username',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
