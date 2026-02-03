import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../widgets/player_bar.dart';
import '../models/music_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access queue from provider
    final songs = context.select<PlayerProvider, List<Song>>((p) => p.queue);

    return Scaffold(
      backgroundColor: Colors.black, // Dark theme base
      body: Row(
        children: [
          // Sidebar (Placeholder for desktop/tablet)
          if (MediaQuery.of(context).size.width > 800) _buildSidebar(context),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header/Top Bar (Placeholder)
                Container(
                  height: 60,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Content
                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return SongRow(song: song);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PlayerBar(),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey[900],
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text("Menu", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text("Home", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.search, color: Colors.white),
            title: Text("Search", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.library_music, color: Colors.white),
            title: Text("Library", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class SongRow extends StatelessWidget {
  final Song song;
  const SongRow({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final currentSong = context.select<PlayerProvider, Song?>(
      (p) => p.currentSong,
    );
    final isPlaying = context.select<PlayerProvider, bool>((p) => p.isPlaying);
    final isCurrent = currentSong?.id == song.id;

    return ListTile(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
        final provider = context.read<PlayerProvider>();
        if (isCurrent) {
          provider.togglePlay();
        } else {
          provider.playSong(song);
        }
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: song.cover,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(color: Colors.grey[800]),
          errorWidget: (context, url, error) => const Icon(Icons.music_note),
        ),
      ),
      title: Text(
        song.title,
        style: TextStyle(
          color: isCurrent ? Colors.green : Colors.white,
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(song.artist, style: const TextStyle(color: Colors.grey)),
      trailing: isCurrent && isPlaying
          ? const Icon(Icons.graphic_eq, color: Colors.green)
          : const SizedBox.shrink(),
    );
  }
}
