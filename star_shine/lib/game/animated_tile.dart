import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:star_shine/game/enums.dart';
import 'package:star_shine/game/game_controller.dart';
import 'package:star_shine/game/tile_model.dart';

class AnimatedTile extends StatelessWidget {
  final TileModel tile;
  final VoidCallback onTap;
  final Gradient gradient;

  const AnimatedTile({
    super.key,
    required this.tile,
    required this.onTap,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final tileModel = tile as TileModel1;
    
    return Positioned(
      left: (MediaQuery.of(context).size.width / 4) * tile.column,
      top: tile.yPosition,
      width: MediaQuery.of(context).size.width / 4,
      height: tileModel.length,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: _getGlowColor(),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background glow
              Container(
                decoration: BoxDecoration(
                  color: _getTileColor().withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              
              // Main tile body
              Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
                child: _buildTileContent(),
              ),
              
              // Top highlight
              Positioned(
                top: 0,
                left: 4,
                right: 4,
                height: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate()
      .fadeIn(duration: 200.milliseconds)
      .slideY(begin: -0.2, end: 0, duration: 200.milliseconds, curve: Curves.easeOut);
  }

  Color _getTileColor() {
    switch (tile.status) {
      case TileStatus.active:
        return Colors.orange.shade400;
      case TileStatus.hit:
        return Colors.green.shade400;
      case TileStatus.missed:
        return Colors.red.shade400;
      default:
        return Colors.orange.shade400;
    }
  }

  Color _getGlowColor() {
    final baseColor = _getTileColor();
    return tile.status == TileStatus.hit
        ? baseColor.withOpacity(0.5)
        : baseColor.withOpacity(0.3);
  }

  // List<Color> _getGradientColors() {
  //   final baseColor = _getTileColor();
  //   return [
  //     baseColor.withOpacity(0.9),
  //     baseColor,
  //     baseColor.withOpacity(0.9),
  //   ];
  // }

  Widget _buildTileContent() {
    switch (tile.status) {
      case TileStatus.hit:
        return Center(
          child: Icon(
            Icons.music_note_rounded,
            color: Colors.white.withOpacity(0.9),
            size: 24,
          ).animate()
            .scale(duration: 200.milliseconds)
            .fadeIn()
            .then()
            .slideY(begin: 0, end: -1, duration: 300.milliseconds),
        );
      case TileStatus.missed:
        return Center(
          child: Icon(
            Icons.close_rounded,
            color: Colors.white.withOpacity(0.9),
            size: 24,
          ).animate()
            .scale(duration: 200.milliseconds)
            .fadeIn(),
        );
      default:
        return Container();
    }
  }
}