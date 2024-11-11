// lib/features/piano_tiles/controllers/audio_controller.dart
import 'package:audioplayers/audioplayers.dart' as player;
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioController {
  final player.AudioPlayer _backgroundPlayer = player.AudioPlayer();
  final player.AudioPlayer _hitSoundPlayer = player.AudioPlayer();
  final AudioCache _audioCache = AudioCache();

  Future<void> initAudio() async {
    await _audioCache.load('audio/amen.mp3');
    // Add any other sound effects you need to pre-load
  }

  Future<void> playBackgroundMusic() async {
    try {
      await _backgroundPlayer.play(AssetSource('audio/amen.mp3'));
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  Future<void> playHitSound() async {
    try {
      await _hitSoundPlayer.play(AssetSource('hit_sound.mp3')); // Add your hit sound file
    } catch (e) {
      print('Error playing hit sound: $e');
    }
  }

  Future<void> pauseBackgroundMusic() async {
    await _backgroundPlayer.pause();
  }

  void dispose() {
    _backgroundPlayer.dispose();
    _hitSoundPlayer.dispose();
  }
}