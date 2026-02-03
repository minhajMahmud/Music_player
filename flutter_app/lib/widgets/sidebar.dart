// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Sidebar extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChange;

  const Sidebar({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: double.infinity,
      color: Colors.black, // bg-sidebar usually dark
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                  ).createShader(bounds),
                  child: Text(
                    "Melodify",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Nav
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                _NavItem(
                  icon: LucideIcons.home,
                  label: "Home",
                  isActive: activeTab == "home",
                  onTap: () => onTabChange("home"),
                ),
                _NavItem(
                  icon: LucideIcons.search,
                  label: "Search",
                  isActive: activeTab == "search",
                  onTap: () => onTabChange("search"),
                ),
                _NavItem(
                  icon: LucideIcons.library,
                  label: "Your Library",
                  isActive: activeTab == "library",
                  onTap: () => onTabChange("library"),
                ),
                _NavItem(
                  icon: LucideIcons.user,
                  label: "Profile",
                  isActive: activeTab == "profile",
                  onTap: () => onTabChange("profile"),
                ),
              ],
            ),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Divider(color: Colors.white.withOpacity(0.1)),
          ),

          // Playlists
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                // Header + Plus
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PLAYLISTS",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          letterSpacing: 1,
                        ),
                      ),
                      const Icon(LucideIcons.plus, size: 20, color: Colors.grey)
                    ],
                  ),
                ),
                // Liked Songs Item
                _PlaylistItem(
                  label: "Liked Songs",
                  special: true,
                  isActive: activeTab == "playlist-liked",
                  onTap: () => onTabChange("playlist-liked"),
                ),
                // Other playlists
                _PlaylistItem(
                  label: "Chill Vibes",
                  isActive: activeTab == "playlist-p2",
                  onTap: () => onTabChange("playlist-p2"),
                ),
                _PlaylistItem(
                  label: "Workout Mix",
                  isActive: activeTab == "playlist-p3",
                  onTap: () => onTabChange("playlist-p3"),
                ),
              ],
            ),
          ),

          // User Profile Section at Bottom
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.orange.shade400,
                      child: Text(
                        authProvider.userName?.substring(0, 1).toUpperCase() ??
                            'G',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            authProvider.userName ?? 'Guest',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (authProvider.isGuest)
                            Text(
                              'Guest Account',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Sign Out Button
                    IconButton(
                      icon: const Icon(LucideIcons.logOut, size: 20),
                      color: Colors.grey,
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
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistItem extends StatelessWidget {
  final String label;
  final bool special;
  final bool isActive;
  final VoidCallback onTap;

  const _PlaylistItem({
    required this.label,
    this.special = false,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (special)
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(LucideIcons.heart,
                    size: 16, color: Colors.white),
              )
            else
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(4),
                ),
                child:
                    const Icon(LucideIcons.music, size: 16, color: Colors.grey),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isActive ? Colors.white : Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
