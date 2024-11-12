import 'package:star_shine/game/enums.dart';

class GameStats {
  final int currentScore;
  final int highScore;
  final int perfectHits;
  final double accuracy;
  final GameLevel level;
  final int levelProgress;

  GameStats({
    this.currentScore = 0,
    this.highScore = 0,
    this.perfectHits = 0,
    this.accuracy = 0.0,
    this.level = GameLevel.normal,
    this.levelProgress = 3,
  });

  GameStats copyWith({
    int? currentScore,
    int? highScore,
    int? perfectHits,
    double? accuracy,
    GameLevel? level,
    int? levelProgress,
  }) {
    return GameStats(
      currentScore: currentScore ?? this.currentScore,
      highScore: highScore ?? this.highScore,
      perfectHits: perfectHits ?? this.perfectHits,
      accuracy: accuracy ?? this.accuracy,
      level: level ?? this.level,
      levelProgress: levelProgress ?? this.levelProgress,
    );
  }
}
