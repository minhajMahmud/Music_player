
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../admin_store.dart';
import '../ui_helpers.dart';

class ArtistsView extends StatefulWidget {
  final AdminStore store;
  final String searchQuery;

  const ArtistsView({super.key, required this.store, required this.searchQuery});

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  @override
  Widget build(BuildContext context) {
    final artists = widget.store.searchArtists(widget.searchQuery);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Artists', style: headingStyle()),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  final created = await showDialog<Artist>(
                    context: context,
                    builder: (_) => _ArtistDialog(),
                  );
                  if (created != null) widget.store.addArtist(created);
                },
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Add Artist'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: sectionCard(
              child: ListView.separated(
                itemCount: artists.length,
                separatorBuilder: (_, __) => Divider(color: Colors.grey.shade800),
                itemBuilder: (context, i) {
                  final a = artists[i];
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade400.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade800),
                      ),
                      child: Icon(LucideIcons.mic2,
                          size: 18, color: Colors.orange.shade300),
                    ),
                    title: Text(a.name,
                        style: bodyStyle().copyWith(fontWeight: FontWeight.w800)),
                    subtitle: Text('${a.genre} • ${a.monthlyListeners} monthly listeners',
                        style: bodyStyle().copyWith(color: Colors.grey.shade400)),
                    trailing: Wrap(
                      spacing: 6,
                      children: [
                        IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(LucideIcons.pencil, size: 18),
                          color: Colors.orange.shade300,
                          onPressed: () async {
                            final updated = await showDialog<Artist>(
                              context: context,
                              builder: (_) => _ArtistDialog(initial: a),
                            );
                            if (updated != null) widget.store.updateArtist(a.id, updated);
                          },
                        ),
                        IconButton(
                          tooltip: 'Delete',
                          icon: const Icon(LucideIcons.trash2, size: 18),
                          color: Colors.red.shade300,
                          onPressed: () async {
                            final ok = await _confirm(
                              context,
                              'Delete "${a.name}"? Songs/Albums will remain but can be reassigned.',
                            );
                            if (ok) widget.store.deleteArtist(a.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _confirm(BuildContext context, String msg) async {
    final res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF18181b),
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: Text(msg, style: TextStyle(color: Colors.grey.shade300)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400, foregroundColor: Colors.black),
            child: const Text('Delete'),
          )
        ],
      ),
    );
    return res ?? false;
  }
}

class _ArtistDialog extends StatefulWidget {
  final Artist? initial;
  const _ArtistDialog({this.initial});

  @override
  State<_ArtistDialog> createState() => _ArtistDialogState();
}

class _ArtistDialogState extends State<_ArtistDialog> {
  late final TextEditingController _name;
  late final TextEditingController _genre;
  late final TextEditingController _listeners;

  @override
  void initState() {
    super.initState();
    final a = widget.initial;
    _name = TextEditingController(text: a?.name ?? '');
    _genre = TextEditingController(text: a?.genre ?? '');
    _listeners = TextEditingController(text: a == null ? '0' : a.monthlyListeners.toString());
  }

  @override
  void dispose() {
    _name.dispose();
    _genre.dispose();
    _listeners.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF18181b),
      title: Text(widget.initial == null ? 'Add Artist' : 'Edit Artist',
          style: const TextStyle(color: Colors.white)),
      content: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _name, decoration: darkInputDecoration('Name'), style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 12),
            TextField(controller: _genre, decoration: darkInputDecoration('Genre'), style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 12),
            TextField(
              controller: _listeners,
              keyboardType: TextInputType.number,
              decoration: darkInputDecoration('Monthly listeners'),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final name = _name.text.trim();
            if (name.isEmpty) return;
            final genre = _genre.text.trim().isEmpty ? 'Unknown' : _genre.text.trim();
            final ml = int.tryParse(_listeners.text.trim()) ?? 0;

            Navigator.pop(
              context,
              Artist(
                id: widget.initial?.id ?? '',
                name: name,
                genre: genre,
                monthlyListeners: ml < 0 ? 0 : ml,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            foregroundColor: Colors.black,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
