import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:star_shine/game/animated_tile.dart';
import 'package:star_shine/game/enums.dart' as game_enums;
import 'package:star_shine/game/game_controller.dart';

class GameScreen extends GetView<GameController> {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration:const  BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Colors.black,
              //     Colors.orange.shade900.withOpacity(0.3),
              //     Colors.black,
              //   ],
              // ),
              image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover),
            ),
          ),

          // Game area with tiles
          _buildGameArea(),

          // // Lives display
          // Positioned(
          //   top: 40,
          //   right: 20,
          //   child: Obx(() => Row(
          //     children: List.generate(3, (index) {
          //       final progress = index;
          //       final isActive = index < progress;
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 4),
          //         child: Icon(
          //           Icons.favorite_rounded,
          //           size: 28,
          //           color: isActive 
          //             ? Colors.orange.shade400
          //             : Colors.grey.shade800,
          //         ).animate(target: isActive ? 1 : 0)
          //           .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2))
          //           .tint(color: isActive ? Colors.orange : Colors.grey.shade800),
          //       );
          //     }),
          //   )),
          // ),

          // Score display with animation
           Positioned(
            top: 30,
           
            right: 170,
            child: Obx(() => Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          color: Colors.orange.shade400,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${controller.gameStats.value.currentScore}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                color: Colors.orange.shade200.withOpacity(0.3)),
                      ],
                    ),
                  ),
                )),
          ),
          Positioned(
            top: 30,
     
            right: 25,
            child:Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: Colors.orange.shade400,
                          size: 24,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: Colors.orange.shade400,
                          size: 24,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: Colors.orange.shade400,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                )),

          // Game state overlays
          Obx(() => _buildGameStateOverlay()),
        ],
      ),
    );
  }

  Widget _buildGameArea() {
    return Stack(
      children: [
        // Column dividers with gradient
        Row(
          children: List.generate(
            4,
            (index) => Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.orange.withOpacity(0.1),
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange.withOpacity(0.05),
                      Colors.orange.withOpacity(0.02),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Updated Tiles
        Obx(() => Stack(
          children: controller.tiles
              .map((tile) => AnimatedTile(
                    tile: tile,
                    onTap: () => controller.onTileTap(tile),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        tile.isSpecial 
                          ? const Color(0xFF4CAF50) 
                          : Colors.orange.shade400,
                      ],
                    ),
                  ))
              .toList(),
        )),
      ],
    );
  }

  Widget _buildGameStateOverlay() {
    switch (controller.gameState.value) {
      case game_enums.GameState.ready:
        return _buildStartScreen();
      case game_enums.GameState.gameOver:
        return _buildGameOverScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStartScreen() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pablow Tiles',
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate()
              .fadeIn(duration: const Duration(seconds: 1))
              .scale(delay: const Duration(milliseconds: 500))
              .shimmer(delay: const Duration(seconds: 1), duration: const Duration(seconds: 2)),
            const SizedBox(height: 40),
            _buildActionButton(
              onPressed: controller.startGame,
              label: 'START GAME',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOverScreen() {
    return Container(
      color: Colors.black.withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GAME OVER',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade400,
              ),
            ).animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .scale(delay: const Duration(milliseconds: 200)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'SCORE',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${controller.gameStats.value.currentScore}',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate()
              .fadeIn(delay: const Duration(milliseconds: 400))
              .slideY(begin: 0.3, duration: const Duration(milliseconds: 600)),
            const SizedBox(height: 40),
            _buildActionButton(
              onPressed: controller.startGame,
              label: 'PLAY AGAIN',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade400,
                Colors.orange.shade700,
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade700.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat())
      .shimmer(duration: const Duration(seconds: 2), color: Colors.white24)
      .animate() // Add a second animation
      .scaleXY(
        begin: 1,
        end: 1.05,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      )
      .then()
      .scaleXY(
        begin: 1.05,
        end: 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
  }
}