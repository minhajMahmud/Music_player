import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../services/firestore_service.dart';
import '../admin/admin_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Container(
      color: const Color(0xFF09090B),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.orange.shade400,
                  child: Text(
                    (authProvider.userName != null &&
                            authProvider.userName!.isNotEmpty)
                        ? authProvider.userName!.substring(0, 1).toUpperCase()
                        : 'G',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  authProvider.userName ?? 'Guest',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (authProvider.userEmail != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    authProvider.userEmail!,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: authProvider.isGuest
                        ? Colors.grey.shade800
                        : Colors.orange.shade400.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: authProvider.isGuest
                          ? Colors.grey.shade600
                          : Colors.orange.shade400,
                    ),
                  ),
                  child: Text(
                    authProvider.isGuest ? 'Guest Account' : 'Premium User',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: authProvider.isGuest
                          ? Colors.grey
                          : Colors.orange.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Settings Section
          const _SectionTitle(title: 'Settings'),
          const SizedBox(height: 12),

          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeThumbColor: Colors.orange.shade400,
            ),
          ),

          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle notifications toggle
              },
              activeThumbColor: Colors.orange.shade400,
            ),
          ),

          _SettingsTile(
            icon: Icons.download_outlined,
            title: 'Download Quality',
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Navigate to download quality settings
            },
          ),

          const SizedBox(height: 24),

          // Account Section
          const _SectionTitle(title: 'Account'),
          const SizedBox(height: 12),

          if (!authProvider.isGuest) ...[
            _SettingsTile(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Navigate to edit profile
              },
            ),
            _SettingsTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Navigate to change password
              },
            ),
          ],

          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Navigate to help
            },
          ),

          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Melodify',
                applicationVersion: '1.0.0',
                applicationIcon: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.music_note_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),
          const _SectionTitle(title: 'Developer Options'),
          const SizedBox(height: 12),
          _SettingsTile(
            icon: Icons.dashboard_outlined,
            title: 'Admin Dashboard',
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // In a real app, check for admin role here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminScreen()),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.cloud_upload_outlined,
            title: 'Populate Database',
            onTap: () async {
              try {
                await FirestoreService().seedDatabase();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Database populated successfully!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
          ),

          const SizedBox(height: 40),

          // Sign Out Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF18181b),
                    title: Text(
                      'Sign Out',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                    content: Text(
                      'Are you sure you want to sign out?',
                      style: GoogleFonts.inter(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          authProvider.signOut();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade400,
                        ),
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Sign Out',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
