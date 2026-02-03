import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../models/music_data.dart';
import '../providers/player_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final bool sizeLg;

  const PlaylistCard({
    super.key,
    required this.playlist,
    this.sizeLg = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PlayerProvider>().playPlaylist(playlist.songs);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: sizeLg ? 240 : 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: playlist.cover,
                    width: double.infinity,
                    height: sizeLg ? 208 : 148,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: Colors.grey[800]),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Brand color?
                      boxShadow: [
                        BoxShadow(color: Colors.black45, blurRadius: 8)
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(LucideIcons.play, color: Colors.black),
                      onPressed: () {
                        context
                            .read<PlayerProvider>()
                            .playPlaylist(playlist.songs);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              playlist.name,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              playlist.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
