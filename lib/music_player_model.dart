import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Song {
  final String title;
  final String artist;
  final String url;
  final String albumArtUrl;

  Song(this.title, this.artist, this.url, this.albumArtUrl);
}

class MusicPlayerModel with ChangeNotifier {
  final List<Song> songs = [
    Song(
        'Song 1',
        'Artist 1',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 2',
        'Artist 2',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 3',
        'Artist 3',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 4',
        'Artist 4',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 5',
        'Artist 5',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 6',
        'Artist 6',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 7',
        'Artist 7',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 8',
        'Artist 8',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 9',
        'Artist 9',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
        'https://via.placeholder.com/150'),
    Song(
        'Song 10',
        'Artist 10',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
        'https://via.placeholder.com/150'),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  late Song _currentSong;
  late int _currentIndex;
  bool _isPlaying = false;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  MusicPlayerModel()
      : _currentSong = Song('', '', '', ''),
        _currentIndex = 0;

  void playSong(int index) {
    _currentIndex = index;
    _currentSong = songs[index];
    _audioPlayer.setUrl(_currentSong.url).then((_) {
      _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    });
  }

  void play() {
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  void next() {
    if (_currentIndex < songs.length - 1) {
      playSong(_currentIndex + 1);
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      playSong(_currentIndex - 1);
    }
  }
}
