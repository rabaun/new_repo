import '../../domain/repositories/sound_repository.dart';
import '../../domain/entities/sound_entity.dart';
import '../datasources/local_audio_data_source.dart';

class SoundRepositoryImpl implements SoundRepository {
  final LocalAudioDataSource _dataSource;

  SoundRepositoryImpl(this._dataSource);

  @override
  Future<void> initializeSounds(List<SoundEntity> sounds) async {
    for (final sound in sounds) {
      await _dataSource.loadSound(sound.id, sound.assetPath);
    }
  }

  @override
  Future<void> setVolume(String soundId, double volume) async {
    await _dataSource.setVolume(soundId, volume);
  }

  @override
  Future<void> play(String soundId) async {
    await _dataSource.play(soundId);
  }

  @override
  Future<void> stop(String soundId) async {
    await _dataSource.stop(soundId);
  }

  @override
  Future<void> stopAll() async {
    await _dataSource.stopAll();
  }

  @override
  Future<void> dispose() async {
    await _dataSource.dispose();
  }

  // В data/repositories/sound_repository_impl.dart
  @override
  bool isPlaying(String soundId) {
    return _dataSource.isPlaying(soundId);
  }
}