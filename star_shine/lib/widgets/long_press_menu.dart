import 'package:flutter/material.dart';

class LongPressMenu extends StatelessWidget {
  final VoidCallback onClose;

  const LongPressMenu({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MenuItem(
                title: 'Save to Playlist',
                onTap: () {
                  // Handle save to playlist
                  onClose();
                },
              ),
              _MenuItem(
                title: 'Download Audio',
                onTap: () {
                  // Handle download audio
                  onClose();
                },
              ),
              _MenuItem(
                title: 'Not Interested',
                onTap: () {
                  // Handle not interested
                  onClose();
                },
              ),
              _MenuItem(
                title: 'Report',
                onTap: () {
                  // Handle report
                  onClose();
                },
                isDestructive: true,
              ),
              _MenuItem(
                title: 'Cancel',
                onTap: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}