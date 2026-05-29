
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../admin_store.dart';
import '../ui_helpers.dart';

class AlbumsView extends StatefulWidget {
  final AdminStore store;
  final String searchQuery;

  const AlbumsView({super.key, required this.store, required this.searchQuery});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  @override
  Widget build(BuildContext context) {
    final albums = widget.store.searchAlbums(widget.searchQuery);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Albums', style: headingStyle()),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  final created = await showDialog<Album>(
                    context: context,
                    builder: (_) => _AlbumDialog(),
                  );
                  if (created != null) widget.store.addAlbum(created);
                },
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Add Album'),
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
              child: GridView.builder(
                itemCount: albums.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1100
                      ? 3
                      : (MediaQuery.of(context).size.width > 750 ? 2 : 1),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 2.9,
                ),
                itemBuilder: (context, i) {
                  final a = albums[i];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade400.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey.shade800),
                          ),
                          child: Icon(LucideIcons.disc,
                              size: 22, color: Colors.orange.shade300),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(a.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: bodyStyle().copyWith(
                                      fontWeight: FontWeight.w800)),
                              const SizedBox(height: 2),
                              Text('${a.artistName} • ${a.year} • ${a.tracks} tracks',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: bodyStyle()
                                      .copyWith(color: Colors.grey.shade400)),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(LucideIcons.pencil, size: 18),
                          color: Colors.orange.shade300,
                          onPressed: () async {
                            final updated = await showDialog<Album>(
                              context: context,
                              builder: (_) => _AlbumDialog(initial: a),
                            );
                            if (updated != null) widget.store.updateAlbum(a.id, updated);
                          },
                        ),
                        IconButton(
                          tooltip: 'Delete',
                          icon: const Icon(LucideIcons.trash2, size: 18),
                          color: Colors.red.shade300,
                          onPressed: () async {
                            final ok = await _confirm(
                              context,
                              'Delete "${a.title}"?',
                            );
                            if (ok) widget.store.deleteAlbum(a.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
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

class _AlbumDialog extends StatefulWidget {
  final Album? initial;
  const _AlbumDialog({this.initial});

  @override
  State<_AlbumDialog> createState() => _AlbumDialogState();
}

class _AlbumDialogState extends State<_AlbumDialog> {
  late final TextEditingController _title;
  late final TextEditingController _artist;
  late final TextEditingController _year;
  late final TextEditingController _tracks;

  @override
  void initState() {
    super.initState();
    final a = widget.initial;
    _title = TextEditingController(text: a?.title ?? '');
    _artist = TextEditingController(text: a?.artistName ?? '');
    _year = TextEditingController(text: a == null ? DateTime.now().year.toString() : a.year.toString());
    _tracks = TextEditingController(text: a == null ? '10' : a.tracks.toString());
  }

  @override
  void dispose() {
    _title.dispose();
    _artist.dispose();
    _year.dispose();
    _tracks.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF18181b),
      title: Text(widget.initial == null ? 'Add Album' : 'Edit Album',
          style: const TextStyle(color: Colors.white)),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _title, decoration: darkInputDecoration('Title'), style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              TextField(controller: _artist, decoration: darkInputDecoration('Artist'), style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _year,
                      keyboardType: TextInputType.number,
                      decoration: darkInputDecoration('Year'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _tracks,
                      keyboardType: TextInputType.number,
                      decoration: darkInputDecoration('Tracks'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final title = _title.text.trim();
            final artist = _artist.text.trim();
            if (title.isEmpty || artist.isEmpty) return;

            final year = int.tryParse(_year.text.trim()) ?? DateTime.now().year;
            final tracks = int.tryParse(_tracks.text.trim()) ?? 0;

            Navigator.pop(
              context,
              Album(
                id: widget.initial?.id ?? '',
                title: title,
                artistName: artist,
                year: year,
                tracks: tracks <= 0 ? 1 : tracks,
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
