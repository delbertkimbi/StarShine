import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ArtistNotificationScreen extends StatelessWidget {
  const ArtistNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Mark all as read functionality
            },
            icon: const Icon(Icons.done_all, size: 20),
            label: Text(
              'Mark all as read',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildNotificationGroup('New'),
          _buildConnectionRequest(),
          _buildMilestoneNotification(),
          const SizedBox(height: 16),
          _buildNotificationGroup('Earlier'),
          _buildFeatureNotification(),
          _buildAIChallengeNotification(),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildConnectionRequest() {
    return _buildNotificationCard(
      icon: Icons.person_add,
      iconColor: Colors.blue,
      iconBackground: Colors.blue.shade50,
      title: 'Connection Request',
      content: 'Ko C wants to connect with you',
      time: '2 hours ago',
      buttons: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Accept',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text(
            'Decline',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneNotification() {
    return _buildNotificationCard(
      icon: Icons.celebration,
      iconColor: Colors.orange,
      iconBackground: Colors.orange.shade50,
      title: 'Milestone Achieved! 🎉',
      content: 'Congratulations! You\'ve reached 1 Million followers and 10,000 daily listeners.',
      time: '5 hours ago',
      buttons: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'View Statistics',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureNotification() {
    return _buildNotificationCard(
      icon: Icons.new_releases,
      iconColor: Colors.purple,
      iconBackground: Colors.purple.shade50,
      title: 'New Features Available',
      content: 'Check out our latest features to enhance your artist experience!',
      time: '1 day ago',
      buttons: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Explore Now',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildAIChallengeNotification() {
    return _buildNotificationCard(
      icon: Icons.lightbulb,
      iconColor: Colors.green,
      iconBackground: Colors.green.shade50,
      title: 'AI-Suggested Challenge',
      content: 'Based on your audience preferences, create a "Summer Acoustic Sessions" challenge to boost engagement.',
      time: '2 days ago',
      buttons: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Create Challenge',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String content,
    required String time,
    List<Widget> buttons = const [],
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            if (buttons.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                children: buttons
                    .map((button) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: button,
                ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}