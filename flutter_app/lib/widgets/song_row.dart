// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../models/music_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SongRow extends StatelessWidget {
  final Song song;
  final int? index;
  final bool compact;
  final ValueChanged<Song>? onPlay;

  const SongRow({
    super.key,
    required this.song,
    this.index,
    this.compact = false,
    this.onPlay,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = context.select<PlayerProvider, Song?>(
      (p) => p.currentSong,
    );
    final isPlaying = context.select<PlayerProvider, bool>((p) => p.isPlaying);
    final isCurrent = currentSong?.id == song.id;

    return InkWell(
      onTap: () {
        if (onPlay != null) {
          onPlay!(song);
        } else {
          final provider = context.read<PlayerProvider>();
          if (isCurrent) {
            provider.togglePlay();
          } else {
            provider.playSong(song);
          }
        }
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isCurrent ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            if (index != null) ...[
              SizedBox(
                width: 24,
                child: isCurrent && isPlaying
                    ? Icon(
                        LucideIcons.barChart2, // Close enough to animated EQ
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : Text(
                        index.toString(),
                        style: TextStyle(
                          color: isCurrent
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
            ],
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: song.cover,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: Colors.grey[800]),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    song.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight:
                          isCurrent ? FontWeight.w600 : FontWeight.normal,
                      color: isCurrent
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!compact)
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
            ),
            if (!compact) ...[
              const SizedBox(width: 16),
              Expanded(
                  child: Text(
                song.album,
                style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
            const SizedBox(width: 16),
            Text(
              _formatDuration(song.duration),
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
