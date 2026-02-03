import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/music_data.dart';
import '../providers/player_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecentCard extends StatelessWidget {
  final Song song;

  const RecentCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Play just this song or find it in default queue?
        // React code finds it in sampleSongs and plays playlist from there
        context.read<PlayerProvider>().playSong(song);
      },
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 64, // h-16
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1), // glass-card like
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
              child: CachedNetworkImage(
                imageUrl: song.cover,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: Colors.grey[800]),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                song.title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Play button on hover? Hard to do on mobile flutter without mouse region,
            // but we can add a simple play icon or keep it clean.
            // The React version has a group-hover effect.
            const Padding(
                padding: EdgeInsets.only(right: 16),
                child:
                    Icon(LucideIcons.playCircle, color: Colors.green, size: 28))
          ],
        ),
      ),
    );
  }
}
