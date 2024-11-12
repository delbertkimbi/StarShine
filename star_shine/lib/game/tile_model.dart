import 'package:star_shine/game/enums.dart';

abstract class TileModel {
  int get id;
  int get column;
  double get position;
  double get yPosition;
  set position(double value);
  set yPosition(double value);
  TileStatus get status;
  set status(TileStatus value);
  bool get isHit;
  set isHit(bool value);
  final bool isSpecial;

  TileModel({
    this.isSpecial = false,
  });
}

class GameStats {
  int currentScore;
  GameStats({this.currentScore = 0});
}

enum GameState {
  ready,
  playing,
  paused,
  gameOver,
}
