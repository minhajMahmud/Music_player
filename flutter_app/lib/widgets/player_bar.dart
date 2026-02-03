import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/player_provider.dart';
import '../models/music_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlayerBar extends StatelessWidget {
  final VoidCallback? onNowPlayingOpen;

  const PlayerBar({super.key, this.onNowPlayingOpen});

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<PlayerProvider>().currentSong == null) {
      return const SizedBox.shrink();
    }

    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      height: isDesktop ? 96 : 80,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: isDesktop
          ? _buildDesktopContent(context)
          : _buildMobileContent(context),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildSongInfo(context)),
          Expanded(flex: 4, child: _buildPlayerControls(context)),
          Expanded(flex: 3, child: _buildVolumeControls(context)),
        ],
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    final provider = context.watch<PlayerProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: _buildSongInfo(context)),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(LucideIcons.skipBack),
            onPressed: provider.prevSong,
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(4), // slightly smaller
            child: GestureDetector(
              onTap: provider.togglePlay,
              child: Icon(
                provider.isPlaying ? LucideIcons.pause : LucideIcons.play,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.skipForward),
            onPressed: provider.nextSong,
          ),
        ],
      ),
    );
  }

  Widget _buildSongInfo(BuildContext context) {
    final song = context.select<PlayerProvider, Song?>((p) => p.currentSong);
    if (song == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onNowPlayingOpen,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: song.cover,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[800]),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.music_note),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: Theme.of(
                    context,
                  )
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.heart),
            onPressed: () {
              // Toggle like logic
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerControls(BuildContext context) {
    final provider = context.watch<PlayerProvider>();
    final song = provider.currentSong;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                LucideIcons.shuffle,
                color: provider.shuffle ? Theme.of(context).primaryColor : null,
                size: 20,
              ),
              onPressed: provider.toggleShuffle,
            ),
            IconButton(
              icon: const Icon(LucideIcons.skipBack),
              onPressed: provider.prevSong,
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(
                  provider.isPlaying ? LucideIcons.pause : LucideIcons.play,
                  color: Colors.black,
                ),
                onPressed: provider.togglePlay,
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.skipForward),
              onPressed: provider.nextSong,
            ),
            IconButton(
              icon: Icon(
                provider.repeat == RepeatMode.one
                    ? LucideIcons.repeat1
                    : LucideIcons.repeat,
                color: provider.repeat != RepeatMode.off
                    ? Theme.of(context).primaryColor
                    : null,
                size: 20,
              ),
              onPressed: provider.toggleRepeat,
            ),
          ],
        ),
        if (song != null)
          Row(
            children: [
              Text(
                _formatDuration(provider.currentTime),
                style: const TextStyle(fontSize: 12),
              ),
              Expanded(
                child: Slider(
                  value: provider.progress.clamp(0.0, 1.0),
                  onChanged: (val) {
                    provider.seek(val);
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white24,
                ),
              ),
              Text(
                _formatDuration(song.duration),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildVolumeControls(BuildContext context) {
    final provider = context.watch<PlayerProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(LucideIcons.mic2, size: 20),
        const SizedBox(width: 16),
        const Icon(LucideIcons.listMusic, size: 20),
        const SizedBox(width: 16),
        const Icon(LucideIcons.monitorSpeaker, size: 20), // 'Volume2' analog
        SizedBox(
          width: 100,
          child: Slider(
            value: provider.volume,
            min: 0,
            max: 100,
            onChanged: (val) => provider.setVolume(val),
            activeColor: Colors.white,
            inactiveColor: Colors.white24,
          ),
        ),
      ],
    );
  }
}
