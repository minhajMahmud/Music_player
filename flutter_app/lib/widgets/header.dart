// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Navigation
          Expanded(
            child: Row(
              children: [
                _NavButton(icon: LucideIcons.chevronLeft, onTap: () {}),
                const SizedBox(width: 8),
                _NavButton(icon: LucideIcons.chevronRight, onTap: () {}),
                if (showSearch) ...[
                  const SizedBox(width: 24),
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(LucideIcons.search, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color),
                              decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey)),
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
          Row(
            children: [
              // Theme Toggle
              Consumer<ThemeProvider>(
                builder: (context, theme, child) => IconButton(
                  icon: Icon(theme.themeMode == ThemeMode.dark
                      ? LucideIcons.sun
                      : LucideIcons.moon),
                  onPressed: () => theme.toggleTheme(),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),

              // Notification
              IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.bell),
                  color: Colors.grey),
              const SizedBox(width: 16),

              // User Menu
              PopupMenuButton(
                  offset: const Offset(0, 48),
                  color: Theme.of(context).cardColor,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey,
                          child: Icon(LucideIcons.user,
                              size: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        Text('Guest',
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        const Icon(LucideIcons.chevronDown, size: 16),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => <PopupMenuEntry>[
                        const PopupMenuItem(child: Text('Account')),
                        const PopupMenuItem(child: Text('Profile')),
                        const PopupMenuItem(child: Text('Settings')),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                            child: Text('Log out',
                                style: TextStyle(color: Colors.red))),
                      ])
            ],
          )
        ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
