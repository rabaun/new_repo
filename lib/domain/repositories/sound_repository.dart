import '../entities/sound_entity.dart';

// В domain/repositories/sound_repository.dart
abstract class SoundRepository {
  Future<void> initializeSounds(List<SoundEntity> sounds);
  Future<void> setVolume(String soundId, double volume);
  Future<void> play(String soundId);
  Future<void> stop(String soundId);
  Future<void> stopAll();
  Future<void> dispose();
  bool isPlaying(String soundId); // Добавляем этот метод
}
