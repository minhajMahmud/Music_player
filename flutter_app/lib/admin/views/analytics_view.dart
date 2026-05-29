
import 'package:flutter/material.dart';
import '../admin_store.dart';
import '../ui_helpers.dart';

class AnalyticsView extends StatelessWidget {
  final AdminStore store;

  const AnalyticsView({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final genre = store.songsByGenre;
    final roles = store.usersByRole;
    final plans = store.subsByPlan;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Analytics', style: headingStyle()),
          const SizedBox(height: 16),

          LayoutBuilder(builder: (context, c) {
            final twoCol = c.maxWidth > 1000;
            return Flex(
              direction: twoCol ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: sectionCard(
                    child: _BarChart(
                      title: 'Songs by Genre',
                      data: genre,
                    ),
                  ),
                ),
                if (twoCol) const SizedBox(width: 16) else const SizedBox(height: 16),
                Expanded(
                  child: sectionCard(
                    child: _BarChart(
                      title: 'Users by Role',
                      data: roles,
                    ),
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: 16),

          sectionCard(
            child: _BarChart(
              title: 'Subscriptions by Plan',
              data: plans,
            ),
          ),

          const SizedBox(height: 16),
          sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Revenue (Derived)', style: headingStyle()),
                const SizedBox(height: 8),
                Text(
                  'Estimated monthly revenue: \$${store.monthlyRevenueUsd.toStringAsFixed(2)}',
                  style: bodyStyle().copyWith(color: Colors.grey.shade300),
                ),
                const SizedBox(height: 8),
                Text(
                  'Note: This demo calculates revenue from Active subscriptions only.',
                  style: bodyStyle().copyWith(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final String title;
  final Map<String, int> data;

  const _BarChart({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final maxV = entries.isEmpty ? 1 : entries.first.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: headingStyle()),
        const SizedBox(height: 12),
        if (entries.isEmpty)
          Text('No data', style: bodyStyle().copyWith(color: Colors.grey.shade400))
        else
          ...entries.map((e) {
            final pct = e.value / maxV;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      e.key,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: bodyStyle().copyWith(color: Colors.grey.shade300),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        height: 12,
                        color: Colors.grey.shade900,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: pct.clamp(0.0, 1.0),
                            child: Container(color: Colors.orange.shade400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 40,
                    child: Text(
                      e.value.toString(),
                      textAlign: TextAlign.right,
                      style: bodyStyle().copyWith(color: Colors.grey.shade300),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }
}
