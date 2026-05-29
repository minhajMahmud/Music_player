// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import 'glass_widgets.dart';

class Header extends StatelessWidget {
  final bool showSearch;
  final ValueChanged<String>? onSearch;

  const Header({
    super.key,
    this.showSearch = false,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: (isDark ? AppTheme.darkCard : AppTheme.lightCard)
                .withOpacity(0.8),
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                width: 1,
              ),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 720;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Navigation
                  Expanded(
                    child: Row(
                      children: [
                        _NavButton(
                          icon: LucideIcons.chevronLeft,
                          onTap: () {
                            // HapticFeedback.lightImpact();
                          },
                        ),
                        const SizedBox(width: 8),
                        _NavButton(
                          icon: LucideIcons.chevronRight,
                          onTap: () {
                            // HapticFeedback.lightImpact();
                          },
                        ),
                        if (showSearch && !isCompact) ...[
                          const SizedBox(width: 24),
                          Flexible(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 400),
                              height: 48,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppTheme.darkCard
                                    : AppTheme.lightCard,
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radiusMedium),
                                border: Border.all(
                                  color: isDark
                                      ? AppTheme.darkBorder
                                      : AppTheme.lightBorder,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.search,
                                    color: isDark
                                        ? AppTheme.darkTextSecondary
                                        : AppTheme.lightTextSecondary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      style: theme.textTheme.bodyLarge,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Search songs, artists, albums...',
                                        border: InputBorder.none,
                                        hintStyle: theme.textTheme.bodySmall,
                                      ),
                                      onChanged: onSearch,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),

                  // Right: User & Theme
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isCompact) ...[
                            // Theme Toggle
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, child) =>
                                  GlassCard(
                                opacity: 0.08,
                                padding: EdgeInsets.zero,
                                child: IconButton(
                                  icon: Icon(
                                    themeProvider.themeMode == ThemeMode.dark
                                        ? LucideIcons.sun
                                        : LucideIcons.moon,
                                  ),
                                  onPressed: () {
                                    // HapticFeedback.lightImpact();
                                    themeProvider.toggleTheme();
                                  },
                                  color: isDark
                                      ? AppTheme.darkTextSecondary
                                      : AppTheme.lightTextSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Notification
                            GlassCard(
                              opacity: 0.08,
                              padding: EdgeInsets.zero,
                              child: IconButton(
                                onPressed: () {
                                  // HapticFeedback.lightImpact();
                                },
                                icon: const Icon(LucideIcons.bell),
                                color: isDark
                                    ? AppTheme.darkTextSecondary
                                    : AppTheme.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],

                          // User Menu
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, _) =>
                                PopupMenuButton<String>(
                              offset: const Offset(0, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radiusMedium),
                              ),
                              color: theme.cardColor,
                              elevation: 8,
                              onSelected: (value) {
                                if (value == 'logout') {
                                  authProvider.signOut();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('$value not implemented yet')),
                                  );
                                }
                              },
                              child: GlassContainer(
                                opacity: 0.08,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            AppTheme.primaryColor,
                                            AppTheme.primaryLight
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: AppTheme.glowShadow,
                                      ),
                                      child: Center(
                                        child: Text(
                                          (authProvider.userName != null &&
                                                  authProvider
                                                      .userName!.isNotEmpty)
                                              ? authProvider.userName!
                                                  .substring(0, 1)
                                                  .toUpperCase()
                                              : 'G',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (!isCompact) ...[
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          authProvider.userName ?? 'Guest',
                                          style: theme.textTheme.titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        LucideIcons.chevronDown,
                                        size: 16,
                                        color: isDark
                                            ? AppTheme.darkTextSecondary
                                            : AppTheme.lightTextSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                    ]
                                  ],
                                ),
                              ),
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem(
                                  value: 'profile',
                                  child: Row(
                                    children: [
                                      const Icon(LucideIcons.user, size: 16),
                                      const SizedBox(width: 12),
                                      Text('Profile',
                                          style: theme.textTheme.bodyLarge),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'settings',
                                  child: Row(
                                    children: [
                                      const Icon(LucideIcons.settings,
                                          size: 16),
                                      const SizedBox(width: 12),
                                      Text('Settings',
                                          style: theme.textTheme.bodyLarge),
                                    ],
                                  ),
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem(
                                  value: 'logout',
                                  child: Row(
                                    children: [
                                      const Icon(LucideIcons.logOut,
                                          size: 16, color: Colors.red),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Log out',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GlassCard(
      opacity: 0.08,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 20,
            color: isDark
                ? AppTheme.darkTextSecondary
                : AppTheme.lightTextSecondary,
          ),
        ),
      ),
    );
  }
}
