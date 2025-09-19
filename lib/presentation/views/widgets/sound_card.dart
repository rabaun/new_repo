import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../domain/entities/sound_entity.dart';

class SoundCard extends StatelessWidget {
  final SoundEntity sound;
  final ValueChanged<double> onVolumeChanged;
  final VoidCallback onToggle;

  const SoundCard({
    Key? key,
    required this.sound,
    required this.onVolumeChanged,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = sound.isPlaying;
    final color = _getColorForSound(sound.name);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? color.withOpacity(0.4) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: isActive ? [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ] : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isActive ? Icons.pause : Icons.play_arrow,
                  color: isActive ? color : Colors.white54,
                  size: 28,
                ),
                onPressed: onToggle,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  sound.name,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.white70,
                    fontSize: 18,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.volume_mute,
                color: isActive ? color : Colors.white54,
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 6,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: isActive ? 10 : 8,
                    ),
                    activeTrackColor: color,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: isActive ? color : Colors.white54,
                  ),
                  child: Slider(
                    value: sound.volume, // Используем текущее значение громкости
                    onChanged: onVolumeChanged,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '${(sound.volume * 100).round()}%', // Показываем текущую громкость
                style: TextStyle(
                  color: isActive ? color : Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColorForSound(String soundName) {
    switch (soundName) {
      case 'Птицы':
        return Colors.green;
      case 'Вода':
        return Colors.blue;
      case 'Костер':
        return Colors.orange;
      case 'Дождь':
        return Colors.lightBlue;
      case 'Сверчок':
        return Colors.brown;
      case 'Поезд':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}