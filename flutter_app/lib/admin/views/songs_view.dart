
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../admin_store.dart';
import '../ui_helpers.dart';

class SongsView extends StatefulWidget {
  final AdminStore store;
  final String searchQuery;

  const SongsView({super.key, required this.store, required this.searchQuery});

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    final songs = widget.store.searchSongs(widget.searchQuery);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Songs', style: headingStyle()),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  final created = await showDialog<Song>(
                    context: context,
                    builder: (_) => _SongDialog(),
                  );
                  if (created != null) widget.store.addSong(created);
                },
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Add Song'),
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
              child: SingleChildScrollView(
                child: DataTable(
                  sortAscending: _sortAscending,
                  sortColumnIndex: _sortColumnIndex,
                  headingTextStyle: bodyStyle().copyWith(
                      fontWeight: FontWeight.w700, color: Colors.grey.shade200),
                  dataTextStyle: bodyStyle().copyWith(color: Colors.grey.shade200),
                  columns: [
                    _col('Title', 0, (a, b) => a.title.compareTo(b.title)),
                    _col('Artist', 1, (a, b) => a.artistName.compareTo(b.artistName)),
                    _col('Album', 2, (a, b) => a.albumTitle.compareTo(b.albumTitle)),
                    _col('Genre', 3, (a, b) => a.genre.compareTo(b.genre)),
                    _col('Duration', 4,
                        (a, b) => a.durationSec.compareTo(b.durationSec)),
                    _col('Streams', 5, (a, b) => a.streams.compareTo(b.streams)),
                    const DataColumn(label: Text('Actions')),
                  ],
                  rows: songs.map((s) {
                    return DataRow(cells: [
                      DataCell(Text(s.title)),
                      DataCell(Text(s.artistName)),
                      DataCell(Text(s.albumTitle)),
                      DataCell(Text(s.genre)),
                      DataCell(Text(formatDuration(s.durationSec))),
                      DataCell(Text(s.streams.toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                            tooltip: 'Edit',
                            icon: const Icon(LucideIcons.pencil, size: 18),
                            color: Colors.orange.shade300,
                            onPressed: () async {
                              final updated = await showDialog<Song>(
                                context: context,
                                builder: (_) => _SongDialog(initial: s),
                              );
                              if (updated != null) {
                                widget.store.updateSong(s.id, updated);
                              }
                            },
                          ),
                          IconButton(
                            tooltip: 'Delete',
                            icon: const Icon(LucideIcons.trash2, size: 18),
                            color: Colors.red.shade300,
                            onPressed: () async {
                              final ok = await _confirm(context,
                                  'Delete "${s.title}"? This cannot be undone.');
                              if (ok) widget.store.deleteSong(s.id);
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _col(String label, int index, int Function(Song, Song) compare) {
    return DataColumn(
      label: Text(label),
      onSort: (colIndex, asc) {
        setState(() {
          _sortColumnIndex = colIndex;
          _sortAscending = asc;
        });
        final list = widget.store.searchSongs(widget.searchQuery).toList();
        list.sort((a, b) => asc ? compare(a, b) : compare(b, a));
      },
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

class _SongDialog extends StatefulWidget {
  final Song? initial;
  const _SongDialog({this.initial});

  @override
  State<_SongDialog> createState() => _SongDialogState();
}

class _SongDialogState extends State<_SongDialog> {
  late final TextEditingController _title;
  late final TextEditingController _artist;
  late final TextEditingController _album;
  late final TextEditingController _genre;
  late final TextEditingController _duration;
  late final TextEditingController _streams;

  @override
  void initState() {
    super.initState();
    final s = widget.initial;
    _title = TextEditingController(text: s?.title ?? '');
    _artist = TextEditingController(text: s?.artistName ?? '');
    _album = TextEditingController(text: s?.albumTitle ?? '');
    _genre = TextEditingController(text: s?.genre ?? '');
    _duration = TextEditingController(text: s == null ? '180' : s.durationSec.toString());
    _streams = TextEditingController(text: s == null ? '0' : s.streams.toString());
  }

  @override
  void dispose() {
    _title.dispose();
    _artist.dispose();
    _album.dispose();
    _genre.dispose();
    _duration.dispose();
    _streams.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF18181b),
      title: Text(widget.initial == null ? 'Add Song' : 'Edit Song',
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
              TextField(controller: _album, decoration: darkInputDecoration('Album'), style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              TextField(controller: _genre, decoration: darkInputDecoration('Genre'), style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _duration,
                      keyboardType: TextInputType.number,
                      decoration: darkInputDecoration('Duration (sec)'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _streams,
                      keyboardType: TextInputType.number,
                      decoration: darkInputDecoration('Streams'),
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
            final album = _album.text.trim();
            final genre = _genre.text.trim();
            if (title.isEmpty || artist.isEmpty) return;

            final dur = int.tryParse(_duration.text.trim()) ?? 0;
            final streams = int.tryParse(_streams.text.trim()) ?? 0;

            Navigator.pop(
              context,
              Song(
                id: widget.initial?.id ?? '',
                title: title,
                artistName: artist,
                albumTitle: album.isEmpty ? 'Singles' : album,
                durationSec: dur <= 0 ? 180 : dur,
                genre: genre.isEmpty ? 'Unknown' : genre,
                streams: streams < 0 ? 0 : streams,
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
