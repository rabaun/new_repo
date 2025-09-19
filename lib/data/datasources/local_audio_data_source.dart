import 'package:just_audio/just_audio.dart';

class LocalAudioDataSource {
  final Map<String, AudioPlayer> _players = {};

  Future<void> loadSound(String soundId, String assetPath) async {
    final player = AudioPlayer();
    _players[soundId] = player;

    try {
      await player.setAsset(assetPath);
      player.setLoopMode(LoopMode.one);
    } catch (e) {
      throw Exception('Failed to load sound: $e');
    }
  }

  Future<void> setVolume(String soundId, double volume) async {
    final player = _players[soundId];
    if (player != null) {
      await player.setVolume(volume);
    }
  }

  Future<void> play(String soundId) async {
    final player = _players[soundId];
    if (player != null) {
      await player.play();
    }
  }

  Future<void> stop(String soundId) async {
    final player = _players[soundId];
    if (player != null) {
      await player.stop();
    }
  }

  Future<void> stopAll() async {
    for (final player in _players.values) {
      await player.stop();
    }
  }

  bool isPlaying(String soundId) {
    final player = _players[soundId];
    return player?.playing ?? false;
  }

  Future<void> dispose() async {
    for (final player in _players.values) {
      await player.dispose();
    }
    _players.clear();
  }

  AudioPlayer? getPlayer(String soundId) {
    return _players[soundId];
  }
}