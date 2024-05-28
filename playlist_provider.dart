import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music/utils/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      artist: "Post Malone",
      audioPath: "audio/rockstar.mp3",
      imagePath: "assets/images/rockstar.jpeg",
      songName: "Rockstar",
    ),
    Song(
      artist: "Imagine Dragons",
      audioPath: "audio/beleiver.mp3",
      imagePath: "assets/images/believer.jpeg",
      songName: "Believer",
    ),
    Song(
      artist: "Coldplay",
      audioPath: "audio/yellow.mp3",
      imagePath: "assets/images/Coldplay.jpeg",
      songName: "Yellow",
    ),
  ];
  
  int? _currentSong;
  final AudioPlayer ap = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  PlaylistProvider() {
    listenDuration();
  }

  void play() async {
    final String path = _playlist[_currentSong!].audioPath;
    await ap.stop();
    await ap.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await ap.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await ap.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pOrR() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  void seek(Duration position) async {
    await ap.seek(position);
    _currentDuration = position;
    notifyListeners();
  }

  void nextSong() {
    if (_currentSong != null) {
      if (_currentSong! < _playlist.length - 1) {
        currentSong = _currentSong! + 1;
      } else {
        currentSong = 0;
      }
    }
  }

  void prevSong() async {
    if (_currentDuration.inSeconds > 3) {
      seek(Duration.zero);
    } else {
      if (_currentSong! > 0) {
        currentSong = _currentSong! - 1;
      } else {
        currentSong = _playlist.length - 1;
      }
    }
  }

  void listenDuration() {
    ap.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    ap.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    ap.onPlayerComplete.listen((event) {
      nextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSong(int? newIndex) {
    _currentSong = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
