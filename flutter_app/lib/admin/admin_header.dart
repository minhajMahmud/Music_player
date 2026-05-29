
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminHeader extends StatelessWidget {
  final String title;

  /// Called whenever the search input changes.
  final ValueChanged<String>? onSearchChanged;

  /// Optional placeholder for the search box.
  final String searchHint;

  /// Optional trailing actions.
  final List<Widget> actions;

  /// When true, hides the search bar (useful for smaller screens).
  final bool hideSearch;

  const AdminHeader({
    super.key,
    required this.title,
    this.onSearchChanged,
    this.searchHint = "Search...",
    this.actions = const [],
    this.hideSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b).withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade800),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),

          if (!hideSearch && !isNarrow) ...[
            _SearchBox(
              hint: searchHint,
              onChanged: onSearchChanged,
            ),
            const SizedBox(width: 16),
          ],

          ...actions,
          if (actions.isNotEmpty) const SizedBox(width: 12),

          IconButton(
            icon: const Icon(LucideIcons.bell, color: Colors.white),
            tooltip: "Notifications",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          const SizedBox(width: 8),

          // Admin Profile
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child:
                      const Icon(LucideIcons.user, size: 16, color: Colors.white),
                ),
                if (!isNarrow) ...[
                  const SizedBox(width: 8),
                  Text(
                    "Admin",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;

  const _SearchBox({required this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon:
              Icon(LucideIcons.search, size: 18, color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
