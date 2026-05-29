// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import 'glass_widgets.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 240,
      height: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        border: Border(
          right: BorderSide(
            color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.primaryLight],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppTheme.glowShadow,
                    ),
                    child: const Icon(
                      LucideIcons.music,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Melodify",
                    style: theme.textTheme.headlineLarge,
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
                  const SizedBox(height: 4),
                  _NavItem(
                    icon: LucideIcons.search,
                    label: "Search",
                    isActive: activeTab == "search",
                    onTap: () => onTabChange("search"),
                  ),
                  const SizedBox(height: 4),
                  _NavItem(
                    icon: LucideIcons.library,
                    label: "Your Library",
                    isActive: activeTab == "library",
                    onTap: () => onTabChange("library"),
                  ),
                  const SizedBox(height: 4),
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
              child: Divider(
                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
              ),
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
                        Icon(
                          LucideIcons.plus,
                          size: 20,
                          color: isDark
                              ? AppTheme.darkTextSecondary
                              : AppTheme.lightTextSecondary,
                        )
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
                  top: BorderSide(
                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                  ),
                ),
              ),
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return Row(
                    children: [
                      // Avatar
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.primaryColor,
                              AppTheme.primaryLight
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: AppTheme.glowShadow,
                        ),
                        child: Center(
                          child: Text(
                            (authProvider.userName != null &&
                                    authProvider.userName!.isNotEmpty)
                                ? authProvider.userName!
                                    .substring(0, 1)
                                    .toUpperCase()
                                : 'G',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
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
                              style: theme.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (authProvider.isGuest)
                              Text(
                                'Guest Account',
                                style: theme.textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ),
                      // Sign Out Button
                      IconButton(
                        icon: Icon(
                          LucideIcons.logOut,
                          size: 20,
                          color: isDark
                              ? AppTheme.darkTextSecondary
                              : AppTheme.lightTextSecondary,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: theme.cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radiusMedium),
                              ),
                              title: Text(
                                'Sign Out',
                                style: theme.textTheme.headlineMedium,
                              ),
                              content: Text(
                                'Are you sure you want to sign out?',
                                style: theme.textTheme.bodyMedium,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    authProvider.signOut();
                                  },
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GlassCard(
      opacity: isActive ? 0.15 : 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 4),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive
                ? AppTheme.primaryColor
                : (isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: isActive ? AppTheme.primaryColor : null,
            ),
          ),
        ],
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GlassCard(
      opacity: isActive ? 0.15 : 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 4),
      onTap: onTap,
      child: Row(
        children: [
          if (special)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryLight],
                ),
                borderRadius: BorderRadius.circular(6),
                boxShadow: isActive ? AppTheme.glowShadow : null,
              ),
              child:
                  const Icon(LucideIcons.heart, size: 16, color: Colors.white),
            )
          else
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                border: Border.all(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                LucideIcons.music,
                size: 16,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isActive ? AppTheme.primaryColor : null,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
