import 'package:flutter/material.dart';

// widgets/action_sidebar.dart
class ActionSidebar extends StatelessWidget {
  final VoidCallback onLyricsPressed;

  const ActionSidebar({
    super.key,
    required this.onLyricsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionButton(
          icon: Icons.favorite,
          label: '123K',
          onPressed: () {},
        ),
        _ActionButton(
          icon: Icons.comment,
          label: '1,234',
          onPressed: () {},
        ),
        _ActionButton(
          icon: Icons.share,
          label: 'Share',
          onPressed: () {},
        ),
        _ActionButton(
          icon: Icons.music_note,
          label: 'Sound',
          onPressed: () {},
        ),
        _ActionButton(
          icon: Icons.playlist_add,
          label: 'Playlist',
          onPressed: () {},
        ),
        _ActionButton(
          icon: Icons.lyrics,
          label: 'Lyrics',
          onPressed: onLyricsPressed,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
