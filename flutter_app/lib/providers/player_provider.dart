import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/music_data.dart';

enum RepeatMode { off, all, one }

class PlayerProvider with ChangeNotifier {
  Song? _currentSong;
  bool _isPlaying = false;
  List<Song> _queue = List.from(sampleSongs);
  int _currentIndex = 0;
  int _currentTime = 0;
  double _volume = 70;
  bool _shuffle = false;
  RepeatMode _repeat = RepeatMode.off;
  Timer? _timer;

  PlayerProvider() {
    if (sampleSongs.isNotEmpty) {
      _currentSong = sampleSongs[0];
    }
  }

  // Getters
  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  List<Song> get queue => _queue;
  int get currentTime => _currentTime;
  double get volume => _volume;
  bool get shuffle => _shuffle;
  RepeatMode get repeat => _repeat;

  double get progress => (_currentSong != null && _currentSong!.duration > 0)
      ? _currentTime / _currentSong!.duration
      : 0.0;

  void playSong(Song song) {
    // If not in queue, just play it without changing queue for now?
    // Or add to top? The original code didn't fully specifying queue logic besides initial load.
    // Let's assume we play from current queue or just simple switch.
    _currentSong = song;
    _isPlaying = true;
    _currentTime = 0;

    final index = _queue.indexWhere((s) => s.id == song.id);
    if (index != -1) {
      _currentIndex = index;
    }

    _startTimer();
    notifyListeners();
  }

  void playPlaylist(List<Song> songs, {int startIndex = 0}) {
    _queue = List.from(songs);
    _currentSong = songs[startIndex];
    _currentIndex = startIndex;
    _isPlaying = true;
    _currentTime = 0;
    _startTimer();
    notifyListeners();
  }

  void togglePlay() {
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      _startTimer();
    } else {
      _stopTimer();
    }
    notifyListeners();
  }

  void nextSong() {
    if (_queue.isEmpty) return;

    int nextIndex;
    if (_shuffle) {
      nextIndex = Random().nextInt(_queue.length);
    } else {
      nextIndex = _currentIndex + 1;
      if (nextIndex >= _queue.length) {
        nextIndex = _repeat == RepeatMode.all ? 0 : _currentIndex;
      }
    }

    _currentIndex = nextIndex;
    _currentSong = _queue[nextIndex];
    _currentTime = 0;
    _startTimer(); // Ensure it keeps playing
    notifyListeners();
  }

  void prevSong() {
    if (_queue.isEmpty) return;

    if (_currentTime > 3) {
      _currentTime = 0;
      notifyListeners();
      return;
    }

    int prevIndex = _currentIndex - 1;
    if (prevIndex < 0) {
      prevIndex = _repeat == RepeatMode.all ? _queue.length - 1 : 0;
    }

    _currentIndex = prevIndex;
    _currentSong = _queue[prevIndex];
    _currentTime = 0;
    _startTimer();
    notifyListeners();
  }

  void setCurrentTime(double val) {
    // val is usually 0.0 to 1.0 from slider? No, in logic it's seconds.
    // But wait, the slider usually gives a value.
    // Let's assume input is seconds.
    if (_currentSong == null) return;
    _currentTime = val.toInt();
    notifyListeners();
  }

  void seek(double progress) {
    if (_currentSong == null) return;
    _currentTime = (progress * _currentSong!.duration).toInt();
    notifyListeners();
  }

  void setVolume(double vol) {
    _volume = vol;
    notifyListeners();
  }

  void toggleShuffle() {
    _shuffle = !_shuffle;
    notifyListeners();
  }

  void toggleRepeat() {
    if (_repeat == RepeatMode.off) {
      _repeat = RepeatMode.all;
    } else if (_repeat == RepeatMode.all) {
      _repeat = RepeatMode.one;
    } else {
      _repeat = RepeatMode.off;
    }
    notifyListeners();
  }

  void _startTimer() {
    _stopTimer(); // Clear existing
    if (!_isPlaying || _currentSong == null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSong == null) return;

      if (_currentTime >= _currentSong!.duration) {
        if (_repeat == RepeatMode.one) {
          _currentTime = 0;
          // Keep playing
        } else {
          nextSong();
        }
      } else {
        _currentTime++;
      }
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
