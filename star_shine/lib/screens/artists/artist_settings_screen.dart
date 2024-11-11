import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ArtistSettingsScreen extends StatelessWidget {
  const ArtistSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildSettingsCategory('Appearance', [
              SettingItem(
                icon: Icons.palette_outlined,
                title: 'Theme',
                subtitle: 'Light',
                onTap: () {
                  _showThemeDialog(context);
                },
              ),
              SettingItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  _showLanguageDialog(context);
                },
              ),
              SettingItem(
                icon: Icons.text_fields,
                title: 'Font Size',
                subtitle: 'Medium',
                onTap: () {
                  _showFontSizeDialog(context);
                },
              ),
            ]),
            _buildSettingsCategory('Account', [
              SettingItem(
                icon: Icons.lock_outline,
                title: 'Privacy',
                subtitle: 'Manage your privacy settings',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Configure notification preferences',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.verified_outlined,
                title: 'Verification',
                subtitle: 'Verify your artist account',
                onTap: () {},
              ),
            ]),
            _buildSettingsCategory('Content & Monetization', [
              SettingItem(
                icon: Icons.attach_money,
                title: 'Monetization Settings',
                subtitle: 'Manage your revenue streams',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.music_note_outlined,
                title: 'Content Preferences',
                subtitle: 'Configure content settings',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.copyright_outlined,
                title: 'Copyright Settings',
                subtitle: 'Manage your content rights',
                onTap: () {},
              ),
            ]),
            _buildSettingsCategory('Community', [
              SettingItem(
                icon: Icons.people_outline,
                title: 'Fan Interactions',
                subtitle: 'Manage fan engagement settings',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.comment_outlined,
                title: 'Comments',
                subtitle: 'Configure comment moderation',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.block_outlined,
                title: 'Blocked Users',
                subtitle: 'Manage blocked accounts',
                onTap: () {},
              ),
            ]),
            _buildSettingsCategory('Support', [
              SettingItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Get help and support',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.bug_report_outlined,
                title: 'Report a Problem',
                subtitle: 'Let us know about any issues',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildDangerZone(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade400,
            Colors.deepOrange.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Verified Artist',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCategory(String title, List<SettingItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        ...items.map((item) => _buildSettingItem(item)),
      ],
    );
  }

  Widget _buildSettingItem(SettingItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: Colors.orange.shade400,
        ),
        title: Text(
          item.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: GoogleFonts.inter(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
        onTap: item.onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
      ),
    );
  }

  Widget _buildDangerZone() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.red.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danger Zone',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: Text(
              'Deactivate Account',
              style: GoogleFonts.inter(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Choose Theme',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('Light Theme', () => Get.back()),
            _buildDialogOption('Dark Theme', () => Get.back()),
            _buildDialogOption('System Default', () => Get.back()),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Choose Language',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('English', () => Get.back()),
            _buildDialogOption('Spanish', () => Get.back()),
            _buildDialogOption('French', () => Get.back()),
            _buildDialogOption('German', () => Get.back()),
          ],
        ),
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Choose Font Size',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('Small', () => Get.back()),
            _buildDialogOption('Medium', () => Get.back()),
            _buildDialogOption('Large', () => Get.back()),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogOption(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.inter(),
      ),
      onTap: onTap,
    );
  }
}

class SettingItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}