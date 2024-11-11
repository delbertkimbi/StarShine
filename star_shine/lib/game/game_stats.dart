import 'package:star_shine/game/enums.dart';

class GameStats {
  final int currentScore;
  final int highScore;
  final int perfectHits;
  final double accuracy;
  final GameLevel level;

  GameStats({
    this.currentScore = 0,
    this.highScore = 0,
    this.perfectHits = 0,
    this.accuracy = 0.0,
    this.level = GameLevel.normal,
  });

  GameStats copyWith({
    int? currentScore,
    int? highScore,
    int? perfectHits,
    double? accuracy,
    GameLevel? level,
  }) {
    return GameStats(
      currentScore: currentScore ?? this.currentScore,
      highScore: highScore ?? this.highScore,
      perfectHits: perfectHits ?? this.perfectHits,
      accuracy: accuracy ?? this.accuracy,
      level: level ?? this.level,
    );
  }
}
