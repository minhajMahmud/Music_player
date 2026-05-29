import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../models/music_data.dart';
import '../providers/player_provider.dart';
import '../theme/app_theme.dart';
import 'glass_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaylistCard extends StatefulWidget {
  final Playlist playlist;
  final bool sizeLg;

  const PlaylistCard({
    super.key,
    required this.playlist,
    this.sizeLg = false,
  });

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GlassCard(
          opacity: 0.08,
          padding: const EdgeInsets.all(16),
          onTap: () {
            // HapticFeedback.lightImpact();
            context.read<PlayerProvider>().playPlaylist(widget.playlist.songs);
          },
          child: SizedBox(
            width: widget.sizeLg ? 240 : 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      child: CachedNetworkImage(
                        imageUrl: widget.playlist.cover,
                        width: double.infinity,
                        height: widget.sizeLg ? 208 : 148,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => ShimmerLoading(
                          child: Container(
                            color: isDark ? Colors.grey[800] : Colors.grey[300],
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: isDark ? Colors.grey[800] : Colors.grey[300],
                          child: const Icon(LucideIcons.music, size: 48),
                        ),
                      ),
                    ),
                    // Animated play button
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      bottom: _isHovered ? 12 : 8,
                      right: 8,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                AppTheme.primaryColor,
                                AppTheme.primaryLight
                              ],
                            ),
                            boxShadow: AppTheme.glowShadow,
                          ),
                          child: IconButton(
                            icon: const Icon(LucideIcons.play,
                                color: Colors.white),
                            onPressed: () {
                              // HapticFeedback.mediumImpact();
                              context
                                  .read<PlayerProvider>()
                                  .playPlaylist(widget.playlist.songs);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.playlist.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.playlist.description,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
