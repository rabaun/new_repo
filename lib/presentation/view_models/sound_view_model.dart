import 'package:flutter/foundation.dart';
import '../../domain/entities/sound_entity.dart';
import '../../domain/repositories/sound_repository.dart';

class SoundViewModel with ChangeNotifier {
  final SoundRepository _repository;
  final List<SoundEntity> _sounds = [];

  SoundViewModel(this._repository, List<SoundEntity> initialSounds) {
    _sounds.addAll(initialSounds);
    _initialize();
  }

  List<SoundEntity> get sounds => _sounds;

  Future<void> _initialize() async {
    await _repository.initializeSounds(_sounds);
  }

  Future<void> setVolume(String soundId, double volume) async {
    final index = _sounds.indexWhere((sound) => sound.id == soundId);
    if (index != -1) {
      // Сначала обновляем UI мгновенно
      _sounds[index] = _sounds[index].copyWith(
        volume: volume,
        isPlaying: volume > 0,
      );
      notifyListeners();

      // Затем обновляем аудио (асинхронно)
      await _repository.setVolume(soundId, volume);

      if (volume > 0 && !_repository.isPlaying(soundId)) {
        await _repository.play(soundId);
      } else if (volume == 0 && _repository.isPlaying(soundId)) {
        await _repository.stop(soundId);
      }
    }
  }

  Future<void> toggleSound(String soundId) async {
    final index = _sounds.indexWhere((sound) => sound.id == soundId);
    if (index != -1) {
      final currentSound = _sounds[index];
      final newVolume = currentSound.isPlaying ? 0.0 : 0.5;
      final newPlayingState = !currentSound.isPlaying;

      // Мгновенное обновление UI
      _sounds[index] = currentSound.copyWith(
        volume: newVolume,
        isPlaying: newPlayingState,
      );
      notifyListeners();

      // Асинхронное обновление аудио
      await _repository.setVolume(soundId, newVolume);

      if (newPlayingState) {
        await _repository.play(soundId);
      } else {
        await _repository.stop(soundId);
      }
    }
  }

  Future<void> stopAll() async {
    // Мгновенное обновление UI
    for (int i = 0; i < _sounds.length; i++) {
      _sounds[i] = _sounds[i].copyWith(volume: 0.0, isPlaying: false);
    }
    notifyListeners();

    // Асинхронная остановка аудио
    await _repository.stopAll();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}