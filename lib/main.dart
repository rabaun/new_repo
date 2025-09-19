import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/entities/sound_entity.dart';
import 'domain/repositories/sound_repository.dart';
import 'data/datasources/local_audio_data_source.dart';
import 'data/repositories/sound_repository_impl.dart';
import 'presentation/view_models/sound_view_model.dart';
import 'presentation/views/sound_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<SoundEntity> sounds = [
    SoundEntity(id: '1', name: 'Птицы', assetPath: 'assets/sounds/birds.mp3'),
    SoundEntity(id: '2', name: 'Вода', assetPath: 'assets/sounds/water.mp3'),
    SoundEntity(id: '3', name: 'Костер', assetPath: 'assets/sounds/fire.mp3'),
    SoundEntity(id: '4', name: 'Дождь', assetPath: 'assets/sounds/rain.mp3'),
    SoundEntity(id: '5', name: 'Сверчок', assetPath: 'assets/sounds/cricket.mp3'),
    SoundEntity(id: '6', name: 'Поезд', assetPath: 'assets/sounds/train.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocalAudioDataSource>(create: (_) => LocalAudioDataSource()),
        Provider<SoundRepository>(
          create: (context) => SoundRepositoryImpl(context.read<LocalAudioDataSource>()),
        ),
        ChangeNotifierProvider<SoundViewModel>(
          create: (context) => SoundViewModel(context.read<SoundRepository>(), sounds),
        ),
      ],
      child: MaterialApp(
        title: 'Sleep Sounds',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
          brightness: Brightness.dark,
        ),
        home: SoundScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}