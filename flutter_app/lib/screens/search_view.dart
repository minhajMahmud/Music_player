import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/music_data.dart';
import '../widgets/song_row.dart';
import '../providers/player_provider.dart';

class SearchView extends StatelessWidget {
  final String query;
  const SearchView({super.key, this.query = ''});

  static const List<Map<String, String>> _genres = [
    {'name': 'Pop', 'color': '0xFFE91E63'},
    {'name': 'Hip-Hop', 'color': '0xFFFF9800'},
    {'name': 'Rock', 'color': '0xFFF44336'},
    {'name': 'Electronic', 'color': '0xFF00BCD4'},
    {'name': 'R&B', 'color': '0xFF9C27B0'},
    {'name': 'Jazz', 'color': '0xFFFFC107'},
    {'name': 'Classical', 'color': '0xFF4CAF50'},
    {'name': 'Indie', 'color': '0xFF3F51B5'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Song> filteredSongs = [];
    if (query.isNotEmpty) {
      filteredSongs = sampleSongs.where((song) {
        final q = query.toLowerCase();
        return song.title.toLowerCase().contains(q) ||
            song.artist.toLowerCase().contains(q) ||
            song.album.toLowerCase().contains(q);
      }).toList();
    }

    return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (query.isEmpty) ...[
              const Text('Browse All',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5),
                  itemCount: _genres.length,
                  itemBuilder: (context, index) {
                    final genre = _genres[index];
                    return Container(
                        decoration: BoxDecoration(
                            color: Color(int.parse(genre['color']!)),
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(16),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(genre['name']!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))));
                  })
            ] else ...[
              const Text('Results for \'\'',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 16),
              if (filteredSongs.isEmpty)
                const Text('No songs found.')
              else
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredSongs.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.white10),
                    itemBuilder: (context, index) => SongRow(
                        song: filteredSongs[index],
                        index: index + 1,
                        onPlay: (s) => Provider.of<PlayerProvider>(context,
                                listen: false)
                            .playPlaylist(filteredSongs, startIndex: index)))
            ]
          ],
        ));
  }
}
