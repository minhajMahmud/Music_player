/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'album.dart' as _i2;
import 'app_user.dart' as _i3;
import 'artist.dart' as _i4;
import 'auth_response.dart' as _i5;
import 'greeting.dart' as _i6;
import 'play_event.dart' as _i7;
import 'playlist.dart' as _i8;
import 'playlist_song.dart' as _i9;
import 'song.dart' as _i10;
import 'subscription.dart' as _i11;
import 'user_favorite.dart' as _i12;
import 'package:backend_client/src/protocol/artist.dart' as _i13;
import 'package:backend_client/src/protocol/album.dart' as _i14;
import 'package:backend_client/src/protocol/song.dart' as _i15;
import 'package:backend_client/src/protocol/playlist.dart' as _i16;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i17;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i18;
export 'album.dart';
export 'app_user.dart';
export 'artist.dart';
export 'auth_response.dart';
export 'greeting.dart';
export 'play_event.dart';
export 'playlist.dart';
export 'playlist_song.dart';
export 'song.dart';
export 'subscription.dart';
export 'user_favorite.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Album) {
      return _i2.Album.fromJson(data) as T;
    }
    if (t == _i3.AppUser) {
      return _i3.AppUser.fromJson(data) as T;
    }
    if (t == _i4.Artist) {
      return _i4.Artist.fromJson(data) as T;
    }
    if (t == _i5.AuthResponse) {
      return _i5.AuthResponse.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.PlayEvent) {
      return _i7.PlayEvent.fromJson(data) as T;
    }
    if (t == _i8.Playlist) {
      return _i8.Playlist.fromJson(data) as T;
    }
    if (t == _i9.PlaylistSong) {
      return _i9.PlaylistSong.fromJson(data) as T;
    }
    if (t == _i10.Song) {
      return _i10.Song.fromJson(data) as T;
    }
    if (t == _i11.Subscription) {
      return _i11.Subscription.fromJson(data) as T;
    }
    if (t == _i12.UserFavorite) {
      return _i12.UserFavorite.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Album?>()) {
      return (data != null ? _i2.Album.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AppUser?>()) {
      return (data != null ? _i3.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Artist?>()) {
      return (data != null ? _i4.Artist.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuthResponse?>()) {
      return (data != null ? _i5.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PlayEvent?>()) {
      return (data != null ? _i7.PlayEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Playlist?>()) {
      return (data != null ? _i8.Playlist.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.PlaylistSong?>()) {
      return (data != null ? _i9.PlaylistSong.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Song?>()) {
      return (data != null ? _i10.Song.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Subscription?>()) {
      return (data != null ? _i11.Subscription.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.UserFavorite?>()) {
      return (data != null ? _i12.UserFavorite.fromJson(data) : null) as T;
    }
    if (t == List<_i13.Artist>) {
      return (data as List).map((e) => deserialize<_i13.Artist>(e)).toList()
          as T;
    }
    if (t == List<_i14.Album>) {
      return (data as List).map((e) => deserialize<_i14.Album>(e)).toList()
          as T;
    }
    if (t == List<_i15.Song>) {
      return (data as List).map((e) => deserialize<_i15.Song>(e)).toList() as T;
    }
    if (t == List<_i16.Playlist>) {
      return (data as List).map((e) => deserialize<_i16.Playlist>(e)).toList()
          as T;
    }
    try {
      return _i17.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i18.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Album => 'Album',
      _i3.AppUser => 'AppUser',
      _i4.Artist => 'Artist',
      _i5.AuthResponse => 'AuthResponse',
      _i6.Greeting => 'Greeting',
      _i7.PlayEvent => 'PlayEvent',
      _i8.Playlist => 'Playlist',
      _i9.PlaylistSong => 'PlaylistSong',
      _i10.Song => 'Song',
      _i11.Subscription => 'Subscription',
      _i12.UserFavorite => 'UserFavorite',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('backend.', '');
    }

    switch (data) {
      case _i2.Album():
        return 'Album';
      case _i3.AppUser():
        return 'AppUser';
      case _i4.Artist():
        return 'Artist';
      case _i5.AuthResponse():
        return 'AuthResponse';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.PlayEvent():
        return 'PlayEvent';
      case _i8.Playlist():
        return 'Playlist';
      case _i9.PlaylistSong():
        return 'PlaylistSong';
      case _i10.Song():
        return 'Song';
      case _i11.Subscription():
        return 'Subscription';
      case _i12.UserFavorite():
        return 'UserFavorite';
    }
    className = _i17.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i18.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Album') {
      return deserialize<_i2.Album>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i3.AppUser>(data['data']);
    }
    if (dataClassName == 'Artist') {
      return deserialize<_i4.Artist>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i5.AuthResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'PlayEvent') {
      return deserialize<_i7.PlayEvent>(data['data']);
    }
    if (dataClassName == 'Playlist') {
      return deserialize<_i8.Playlist>(data['data']);
    }
    if (dataClassName == 'PlaylistSong') {
      return deserialize<_i9.PlaylistSong>(data['data']);
    }
    if (dataClassName == 'Song') {
      return deserialize<_i10.Song>(data['data']);
    }
    if (dataClassName == 'Subscription') {
      return deserialize<_i11.Subscription>(data['data']);
    }
    if (dataClassName == 'UserFavorite') {
      return deserialize<_i12.UserFavorite>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i17.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i18.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
