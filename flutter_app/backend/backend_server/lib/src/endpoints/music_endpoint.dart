import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class MusicEndpoint extends Endpoint {
  // Artists
  Future<List<Artist>> getAllArtists(Session session) async {
    return await Artist.db.find(session, orderBy: (t) => t.name);
  }

  Future<Artist?> getArtist(Session session, UuidValue id) async {
    return await Artist.db.findById(session, id);
  }

  Future<void> addArtist(Session session, Artist artist) async {
    await Artist.db.insertRow(session, artist);
  }

  // Albums
  Future<List<Album>> getAlbums(Session session, {UuidValue? artistId}) async {
    return await Album.db.find(
      session,
      where: artistId != null ? (t) => t.artistId.equals(artistId) : null,
      orderBy: (t) => t.releaseYear,
    );
  }

  Future<void> addAlbum(Session session, Album album) async {
    await Album.db.insertRow(session, album);
  }

  // Songs
  Future<List<Song>> getSongs(
    Session session, {
    UuidValue? artistId,
    UuidValue? albumId,
  }) async {
    return await Song.db.find(
      session,
      where: (t) {
        Expression? expr;
        if (artistId != null) expr = t.artistId.equals(artistId);
        if (albumId != null) {
          final albumExpr = t.albumId.equals(albumId);
          expr = expr != null ? (expr & albumExpr) : albumExpr;
        }
        return expr ?? Constant.bool(true);
      },
      orderBy: (t) => t.title,
    );
  }

  Future<void> addSong(Session session, Song song) async {
    await Song.db.insertRow(session, song);
  }

  // Playlists
  Future<List<Playlist>> getPlaylists(Session session) async {
    return await Playlist.db.find(session);
  }

  Future<void> createPlaylist(Session session, Playlist playlist) async {
    await Playlist.db.insertRow(session, playlist);
  }
}
