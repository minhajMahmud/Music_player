// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/music_data.dart';
import '../widgets/playlist_card.dart';
import '../widgets/recent_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning";
    if (hour < 18) return "Good afternoon";
    return "Good evening";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          const SizedBox(height: 20),
          Text(
            _getGreeting(),
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 24),

          // Quick Access Grid
          // Using GridView inside scroll view requires ShrinkWrap or SizedBox
          LayoutBuilder(
            builder: (context, constraints) {
              // Adaptive columns
              int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 3, // Wide cards
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: recentlyPlayed.take(6).length,
                itemBuilder: (context, index) {
                  return RecentCard(song: recentlyPlayed[index]);
                },
              );
            },
          ),

          const SizedBox(height: 40),

          // Made For You
          _buildSectionHeader(context, "Made For You"),
          const SizedBox(height: 16),
          SizedBox(
            height: 340, // Expanded height for large cards
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: madeForYou.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                return PlaylistCard(playlist: madeForYou[index], sizeLg: true);
              },
            ),
          ),

          const SizedBox(height: 40),

          // Featured Playlists
          _buildSectionHeader(context, "Featured Playlists"),
          const SizedBox(height: 16),
          SizedBox(
            height: 280, // Expanded height for normal cards
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: featuredPlaylists.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                return PlaylistCard(playlist: featuredPlaylists[index]);
              },
            ),
          ),

          const SizedBox(height: 40),

          // Recently Played (Songs displayed as cards? React code does this)
          _buildSectionHeader(context, "Recently Played"),
          const SizedBox(height: 16),
          SizedBox(
            height: 220, // Reuse roughly same height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyPlayed.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                // The react code used a generic card style for recent songs here too
                // We can reuse PlaylistCard style but mapped to song or make a new one.
                // For simplicity, let's make a mini-wrapper using common UI structure
                final song = recentlyPlayed[index];
                // Creating ad-hoc playlist from song to reuse card?
                // Or better, just a simple graphic.
                return _buildSongCard(context, song);
              },
            ),
          ),
          const SizedBox(height: 80), // Bottom padding for player bar
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Show all",
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSongCard(BuildContext context, Song song) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              song.cover,
              width: double.infinity,
              height: 118,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[800]),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            song.title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            song.artist,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
