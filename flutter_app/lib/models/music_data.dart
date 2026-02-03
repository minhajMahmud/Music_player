class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int duration; // in seconds
  final String cover;
  final String? audioUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.cover,
    this.audioUrl,
  });
}

class Playlist {
  final String id;
  final String name;
  final String description;
  final String cover;
  final List<Song> songs;
  final String gradient;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.songs,
    required this.gradient,
  });
}

final List<Song> sampleSongs = [
  Song(
    id: "1",
    title: "Midnight Dreams",
    artist: "Luna Wave",
    album: "Neon Nights",
    duration: 234,
    cover:
        "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
  ),
  Song(
    id: "2",
    title: "Electric Soul",
    artist: "The Synth Collective",
    album: "Digital Hearts",
    duration: 198,
    cover:
        "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=300&h=300&fit=crop",
  ),
  Song(
    id: "3",
    title: "Starlight",
    artist: "Nova",
    album: "Cosmic Journey",
    duration: 267,
    cover:
        "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300&h=300&fit=crop",
  ),
  Song(
    id: "4",
    title: "Ocean Waves",
    artist: "Calm Collective",
    album: "Serenity",
    duration: 312,
    cover:
        "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&h=300&fit=crop",
  ),
  Song(
    id: "5",
    title: "City Lights",
    artist: "Urban Echo",
    album: "Metropolitan",
    duration: 189,
    cover:
        "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop",
  ),
  Song(
    id: "6",
    title: "Summer Breeze",
    artist: "Tropical Vibes",
    album: "Paradise",
    duration: 245,
    cover:
        "https://images.unsplash.com/photo-1506157786151-b8491531f063?w=300&h=300&fit=crop",
  ),
  Song(
    id: "7",
    title: "Neon Dreams",
    artist: "Synthwave Kings",
    album: "Retro Future",
    duration: 278,
    cover:
        "https://images.unsplash.com/photo-1571330735066-03aaa9429d89?w=300&h=300&fit=crop",
  ),
  Song(
    id: "8",
    title: "Moonlight Sonata",
    artist: "Classical Remix",
    album: "Timeless",
    duration: 356,
    cover:
        "https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=300&h=300&fit=crop",
  ),
];

final List<Playlist> featuredPlaylists = [
  Playlist(
    id: "p1",
    name: "Today's Top Hits",
    description: "The hottest tracks right now",
    cover:
        "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop",
    gradient: "from-purple-600 to-blue-600",
    songs: sampleSongs.sublist(0, 4),
  ),
  Playlist(
    id: "p2",
    name: "Chill Vibes",
    description: "Kick back and relax",
    cover:
        "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&h=300&fit=crop",
    gradient: "from-teal-500 to-emerald-600",
    songs: sampleSongs.sublist(2, 6),
  ),
  Playlist(
    id: "p3",
    name: "Workout Energy",
    description: "Power through your workout",
    cover:
        "https://images.unsplash.com/photo-1571330735066-03aaa9429d89?w=300&h=300&fit=crop",
    gradient: "from-orange-500 to-red-600",
    songs: sampleSongs.sublist(4, 7), // Updated to fit range
  ),
  Playlist(
    id: "p4",
    name: "Late Night Jazz",
    description: "Smooth jazz for the evening",
    cover:
        "https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=300&h=300&fit=crop",
    gradient: "from-indigo-600 to-purple-700",
    songs: sampleSongs.sublist(1, 5),
  ),
  Playlist(
    id: "p5",
    name: "Electronic Dreams",
    description: "Best electronic & EDM tracks",
    cover:
        "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=300&h=300&fit=crop",
    gradient: "from-cyan-500 to-blue-600",
    songs: sampleSongs.sublist(0, 4),
  ),
];

final List<Song> recentlyPlayed = sampleSongs.sublist(0, 6);

final List<Playlist> madeForYou = [
  Playlist(
    id: "m1",
    name: "Daily Mix 1",
    description: "Luna Wave, Nova and more",
    cover:
        "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300&h=300&fit=crop",
    gradient: "from-green-600 to-teal-600",
    songs: sampleSongs.sublist(0, 4),
  ),
  Playlist(
    id: "m2",
    name: "Discover Weekly",
    description: "Your weekly mixtape of fresh music",
    cover:
        "https://images.unsplash.com/photo-1506157786151-b8491531f063?w=300&h=300&fit=crop",
    gradient: "from-pink-500 to-rose-600",
    songs: sampleSongs.sublist(2, 6),
  ),
  Playlist(
    id: "m3",
    name: "Release Radar",
    description: "Catch all the latest releases",
    cover:
        "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop",
    gradient: "from-violet-600 to-purple-700",
    songs: sampleSongs.sublist(4, 7), // Updated fit range
  ),
];
