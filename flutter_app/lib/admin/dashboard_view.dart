
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'admin_store.dart';
import 'components/stats_card.dart';
import 'ui_helpers.dart';

class DashboardView extends StatelessWidget {
  final AdminStore store;

  const DashboardView({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final revenue = store.monthlyRevenueUsd;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final crossAxisCount = w > 1200 ? 4 : (w > 800 ? 2 : 1);

              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StatsCard(
                    title: "Total Songs",
                    value: store.totalSongs.toString(),
                    change: "+${(store.totalSongs / 10).toStringAsFixed(1)}%",
                    isPositive: true,
                    icon: LucideIcons.music,
                  ),
                  StatsCard(
                    title: "Artists",
                    value: store.totalArtists.toString(),
                    change: "+${(store.totalArtists / 5).toStringAsFixed(1)}%",
                    isPositive: true,
                    icon: LucideIcons.mic2,
                  ),
                  StatsCard(
                    title: "Users",
                    value: store.totalUsers.toString(),
                    change: "${store.totalUsers.isEven ? '+' : '-'}1.2%",
                    isPositive: store.totalUsers.isEven,
                    icon: LucideIcons.users,
                  ),
                  StatsCard(
                    title: "Monthly Revenue",
                    value: "\$${revenue.toStringAsFixed(2)}",
                    change: "+3.4%",
                    isPositive: true,
                    icon: LucideIcons.dollarSign,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          LayoutBuilder(builder: (context, c) {
            final twoCol = c.maxWidth > 1000;
            return Flex(
              direction: twoCol ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quick Overview", style: headingStyle()),
                        const SizedBox(height: 12),
                        _MiniKpiRow(
                          label: 'Active Subscriptions',
                          value: store.activeSubscriptions.toString(),
                          icon: LucideIcons.creditCard,
                        ),
                        const SizedBox(height: 10),
                        _MiniKpiRow(
                          label: 'Albums',
                          value: store.totalAlbums.toString(),
                          icon: LucideIcons.disc,
                        ),
                        const SizedBox(height: 10),
                        _MiniKpiRow(
                          label: 'Top Genre',
                          value: _topKey(store.songsByGenre),
                          icon: LucideIcons.sparkles,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Tip: Use the search bar to filter tables in Songs/Users/Subscriptions.",
                          style: bodyStyle().copyWith(color: Colors.grey.shade300),
                        ),
                      ],
                    ),
                  ),
                ),
                if (twoCol) const SizedBox(width: 16) else const SizedBox(height: 16),
                Expanded(
                  flex: 3,
                  child: sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recent Items (Mock)", style: headingStyle()),
                        const SizedBox(height: 12),
                        ...store.songs.take(4).map((s) => _RecentTile(
                              icon: LucideIcons.music,
                              title: s.title,
                              subtitle: '${s.artistName} • ${s.albumTitle}',
                              trailing: formatDuration(s.durationSec),
                            )),
                        const SizedBox(height: 12),
                        ...store.users.take(3).map((u) => _RecentTile(
                              icon: LucideIcons.user,
                              title: u.name,
                              subtitle: u.email,
                              trailing: u.active ? 'Active' : 'Disabled',
                              trailingColor:
                                  u.active ? Colors.green.shade300 : Colors.red.shade300,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _topKey(Map<String, int> m) {
    if (m.isEmpty) return '—';
    final sorted = m.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }
}

class _MiniKpiRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MiniKpiRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.orange.shade400.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child: Icon(icon, size: 18, color: Colors.orange.shade300),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: bodyStyle().copyWith(color: Colors.grey.shade300)),
        ),
        Text(value, style: bodyStyle().copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }
}

class _RecentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;
  final Color? trailingColor;

  const _RecentTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.trailingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange.shade300, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: bodyStyle().copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: bodyStyle().copyWith(color: Colors.grey.shade400)),
              ],
            ),
          ),
          Text(trailing,
              style: bodyStyle().copyWith(color: trailingColor ?? Colors.grey.shade300)),
        ],
      ),
    );
  }
}
