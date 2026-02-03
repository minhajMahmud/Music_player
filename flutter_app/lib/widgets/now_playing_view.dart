import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/player_provider.dart';

class NowPlayingView extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const NowPlayingView(
      {super.key, required this.isOpen, required this.onClose});

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    final player = Provider.of<PlayerProvider>(context);
    final song = player.currentSong;

    if (song == null) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withOpacity(0.95), // High opacity background
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(LucideIcons.chevronDown,
                          color: Colors.white),
                      onPressed: onClose),
                  Expanded(
                      child: Column(
                    children: [
                      const Text("NOW PLAYING",
                          style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 1.5,
                              color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        song.album,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
                  IconButton(
                    icon: const Icon(LucideIcons.moreHorizontal,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Art
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: song.cover,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[900]),
                          errorWidget: (context, url, error) =>
                              const Icon(LucideIcons.music, size: 60),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Info
                    Text(
                      song.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      song.artist,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),

                    // Placeholder for Lyrics
                    const Text(
                        "♪ Intro ♪\n\nWalking through the midnight streets\nNeon lights are all I see\n...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white54, fontSize: 18, height: 1.5))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
