import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/sound_view_model.dart';
import './widgets/sound_card.dart';

class SoundScreen extends StatelessWidget {
  const SoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SoundViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sleep Sounds',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.deepPurple[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: viewModel.stopAll,
            tooltip: 'Остановить все звуки',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple[800]!,
              Colors.indigo[900]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Регулируйте громкость каждого звука\nПеретащите ползунок вправо чтобы включить',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: viewModel.sounds.map((sound) {
                  return SoundCard(
                    sound: sound,
                    onVolumeChanged: (volume) => viewModel.setVolume(sound.id, volume),
                    onToggle: () => viewModel.toggleSound(sound.id),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Сочетайте разные звуки для создания идеальной атмосферы',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
