import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:star_shine/game/audio_controller.dart';
import 'package:star_shine/game/enums.dart' as game_enums;
import 'package:star_shine/game/enums.dart';
import 'package:star_shine/game/tile_model.dart';

class GameController extends GetxController {
  final AudioController audioController;
  final RxList<TileModel> tiles = <TileModel>[].obs;
  final Rx<game_enums.GameState> gameState = game_enums.GameState.ready.obs;
  final gameStats = Rx<GameStats>(GameStats());
  
  Timer? _gameTimer;
  Timer? _spawnTimer;
  final double baseSpeed = 250.0; // pixels per second
  final random = Random();
  
  // Music beat timing (adjust these based on your music)
  final List<double> tileLengths = [80, 120, 160, 200]; // Different tile lengths
  final double beatInterval = 0.5; // Seconds between beats
  
  GameController({required this.audioController});
  
  @override
  void onInit() {
    super.onInit();
    initAudio();
    ever(gameState, _handleGameStateChange);
  }
  
  void _handleGameStateChange(game_enums.GameState state) {
    if (state == game_enums.GameState.playing) {
      audioController.playBackgroundMusic();
    } else {
      audioController.pauseBackgroundMusic();
    }
  }
  
  Future<void> initAudio() async {
    try {
      await audioController.initAudio();
    } catch (e) {
      print('Error loading audio: $e');
    }
  }
  
  void startGame() {
    if (gameState.value != game_enums.GameState.playing) {
      gameState.value = game_enums.GameState.playing;
      tiles.clear();
      gameStats.value = GameStats();
      _startGameLoop();
      _startTileSpawner();
    }
  }

  void _startGameLoop() {
    const updateInterval = Duration(milliseconds: 16); // ~60 FPS
    _gameTimer?.cancel();
    
    _gameTimer = Timer.periodic(updateInterval, (timer) {
      if (gameState.value == game_enums.GameState.playing) {
        _updateTiles(updateInterval.inMilliseconds / 1000.0);
      }
    });
  }

  void _startTileSpawner() {
    _spawnTimer?.cancel();
    
    _spawnTimer = Timer.periodic(Duration(milliseconds: (beatInterval * 1000).round()), (timer) {
      if (gameState.value == game_enums.GameState.playing) {
        _spawnTile();
      }
    });
  }

  void _spawnTile() {
    final column = random.nextInt(4); // Random column (0-3)
    final length = tileLengths[random.nextInt(tileLengths.length)];
    final speedVariation = 0.8 + (random.nextDouble() * 0.4); // Speed variation 0.8-1.2
    
    final tile = TileModel1(
      id: DateTime.now().millisecondsSinceEpoch,
      column: column,
      position: -length / Get.height, // Start above screen
      status: TileStatus.active,
      yPosition: -length,
      length: length,
      speed: baseSpeed * speedVariation * (1 + (gameStats.value.currentScore / 1000)), // Speed increases with score
    );
    
    tiles.add(tile);
  }

  void _updateTiles(double dt) {
    final screenHeight = Get.height;
    
    for (var tile in tiles) {
      if (tile.status == TileStatus.active) {
        // Update position based on tile's speed
        final movement = (tile as TileModel1).speed * dt;
        tile.yPosition += movement;
        tile.position = tile.yPosition / screenHeight;
        
        // Check if tile is completely off screen
        if (tile.yPosition > screenHeight + tile.length) {
          if (!tile.isHit) {
            tile.status = TileStatus.missed;
            gameOver();
          }
        }
      }
    }
    
    // Remove hit tiles and those that are off screen
    tiles.removeWhere((tile) => 
      tile.status == TileStatus.hit || 
      (tile.status == TileStatus.missed && tile.yPosition > Get.height + (tile as TileModel1).length));
  }

  void onTileTap(TileModel tile) {
    if (gameState.value != game_enums.GameState.playing) return;
    
    final screenHeight = Get.height;
    final tileModel = tile as TileModel1;
    
    // Check if tap is within the visible part of the tile
    if (!tile.isHit && 
        tile.yPosition > 0 && 
        tile.yPosition < screenHeight) {
      tile.isHit = true;
      tile.status = TileStatus.hit;
      audioController.playHitSound();
      
      // Score based on accuracy
      final accuracy = 1.0 - (tile.yPosition.abs() / screenHeight);
      final points = (accuracy * 15).round() + 5; // 5-20 points based on accuracy
      
      gameStats.update((stats) {
        if (stats != null) {
          stats.currentScore += points;
        }
      });
    }
  }

  void gameOver() {
    gameState.value = game_enums.GameState.gameOver;
    _gameTimer?.cancel();
    _spawnTimer?.cancel();
    audioController.pauseBackgroundMusic();
  }

  void pauseGame() {
    if (gameState.value == game_enums.GameState.playing) {
      gameState.value = game_enums.GameState.paused;
      // Add any pause logic here (e.g., stopping timers)
    }
  }

  void resumeGame() {
    if (gameState.value == game_enums.GameState.paused) {
      gameState.value = game_enums.GameState.playing;
      // Add any resume logic here
    }
  }

  @override
  void onClose() {
    _gameTimer?.cancel();
    _spawnTimer?.cancel();
    super.onClose();
  }
}

// Enhanced TileModel
class TileModel1 implements TileModel {
  @override final int id;
  @override final int column;
  @override double position;
  TileStatus _status;
  double _yPosition;
  final double length; // Tile length in pixels
  final double speed; // Pixels per second
  
  @override TileStatus get status => _status;
  @override set status(TileStatus value) => _status = value;
  @override double get yPosition => _yPosition;
  @override set yPosition(double value) => _yPosition = value;
  @override bool isHit = false;
  @override bool isSpecial = false;
  
  TileModel1({
    required this.id,
    required this.column,
    required this.position,
    required TileStatus status,
    required double yPosition,
    required this.length,
    required this.speed,
    this.isHit = false,
    this.isSpecial = false,
  }) : _yPosition = yPosition,
       _status = status;
}