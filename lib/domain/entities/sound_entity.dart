class SoundEntity {
  final String id;
  final String name;
  final String assetPath;
  final double volume;
  final bool isPlaying;

  SoundEntity({
    required this.id,
    required this.name,
    required this.assetPath,
    this.volume = 0.0,
    this.isPlaying = false,
  });

  SoundEntity copyWith({
    String? id,
    String? name,
    String? assetPath,
    double? volume,
    bool? isPlaying,
  }) {
    return SoundEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      assetPath: assetPath ?? this.assetPath,
      volume: volume ?? this.volume,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}