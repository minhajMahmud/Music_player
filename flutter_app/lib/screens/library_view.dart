// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart'; // Add this for context usage if needed later
import '../models/music_data.dart';
import '../widgets/song_row.dart';
import '../widgets/playlist_card.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  int _selectedTab = 0;
  final List<String> _tabs = ["Playlists", "Songs", "Albums", "Artists"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Library",
                style: GoogleFonts.inter(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text("Create Playlist"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: const StadiumBorder(),
                ),
              )
            ],
          ),
          const SizedBox(height: 32),

          // Tabs
          Row(
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTab == index;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_tabs[index]),
                  selected: isSelected,
                  onSelected: (val) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  backgroundColor: Theme.of(context).cardColor,
                  selectedColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  shape: const StadiumBorder(side: BorderSide.none),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),

          // Liked Songs Header (Banner)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7C3AED),
                  Color(0xFF3B82F6)
                ], // Purple to Blue
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Big Heart Icon
                Container(
                  width: 192, // w-48
                  height: 192,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6D28D9), Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ]),
                  child: const Center(
                    child:
                        Icon(LucideIcons.heart, size: 80, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("PLAYLIST",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    Text("Liked Songs",
                        style: GoogleFonts.inter(
                            fontSize: 48, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 16),
                    Text("${sampleSongs.length} songs",
                        style: const TextStyle(color: Colors.white70)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Table Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SizedBox(width: 40), // Space for number
                Expanded(
                    flex: 4,
                    child: Text("#   Title",
                        style: TextStyle(color: Colors.grey, fontSize: 13))),
                Expanded(
                    flex: 3,
                    child: Text("Album",
                        style: TextStyle(color: Colors.grey, fontSize: 13))),
                SizedBox(
                    width: 60,
                    child:
                        Icon(LucideIcons.clock, size: 14, color: Colors.grey)),
              ],
            ),
          ),
          const Divider(color: Colors.white12),

          // Song List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sampleSongs.length,
            itemBuilder: (context, index) {
              return SongRow(song: sampleSongs[index], index: index + 1);
            },
          ),

          const SizedBox(height: 48),

          Text("Your Playlists",
              style:
                  GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              childAspectRatio: 0.8,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: featuredPlaylists.length,
            itemBuilder: (context, index) {
              return PlaylistCard(playlist: featuredPlaylists[index]);
            },
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
