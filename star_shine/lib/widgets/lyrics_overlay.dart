import 'package:flutter/material.dart';

// widgets/lyrics_overlay.dart
class LyricsOverlay extends StatelessWidget {
  const LyricsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: Text(
          'Lyrics will appear here...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}