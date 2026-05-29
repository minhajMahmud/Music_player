import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSidebar extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;
  final bool collapsed;
  final VoidCallback onToggleCollapse;

  const AdminSidebar({
    super.key,
    required this.activeTab,
    required this.onTabChange,
    required this.collapsed,
    required this.onToggleCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: collapsed ? 70 : 250,
      decoration: BoxDecoration(
        color: const Color(0xFF18181b), // bg-card
        border: Border(
          right: BorderSide(color: Colors.grey.shade800),
        ),
      ),
      child: Column(
        children: [
          // Header
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: collapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (!collapsed)
                    Text(
                      "Melodify Admin",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      collapsed ? Icons.chevron_right : Icons.chevron_left,
                      color: Colors.white,
                    ),
                    onPressed: onToggleCollapse,
                    tooltip: collapsed ? "Expand" : "Collapse",
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 16),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildMenuItem(
                    "dashboard", LucideIcons.layoutDashboard, "Dashboard"),
                _buildMenuItem("songs", LucideIcons.music, "Songs"),
                _buildMenuItem("artists", LucideIcons.mic2, "Artists"),
                _buildMenuItem("albums", LucideIcons.disc,
                    "Albums"), // LucideIcons.disc3 not in package? using disc
                _buildMenuItem("users", LucideIcons.users, "Users"),
                _buildMenuItem(
                    "subscriptions", LucideIcons.creditCard, "Subscriptions"),
                _buildMenuItem("analytics", LucideIcons.barChart3, "Analytics"),
                _buildMenuItem("settings", LucideIcons.settings, "Settings"),
              ],
            ),
          ),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildMenuItem("logout", LucideIcons.logOut, "Logout",
                isDestructive: true),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String id, IconData icon, String label,
      {bool isDestructive = false}) {
    final isActive = activeTab == id;
    final color = isDestructive
        ? Colors.red
        : (isActive ? Colors.orange.shade400 : Colors.grey.shade400);

    return InkWell(
      onTap: () {
        if (id != "logout") {
          onTabChange(id);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isActive && !isDestructive
              ? Colors.orange.shade400.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment:
              collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            if (!collapsed) ...[
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
