// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:star_shine/game/game_controller.dart';
// import 'package:star_shine/game/tile_model.dart';
// import 'package:star_shine/game/enums.dart' hide GameState;

// class GamePage extends StatelessWidget {
//   final GameController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return WillPopScope(
//       onWillPop: () async {
//         controller.pauseGame();
//         return true;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/background.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: SafeArea(
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     _buildHeader(),
//                     Expanded(child: _buildGameArea()),
//                   ],
//                 ),
                
//                 // Overlay screens
//                 Obx(() {
//                   if (controller.gameState.value == GameState.ready) {
//                     return _buildStartOverlay();
//                   } else if (controller.gameState.value == GameState.paused) {
//                     return _buildPauseOverlay();
//                   } else if (controller.gameState.value == GameState.gameOver) {
//                     return _buildGameOverOverlay();
//                   }
//                   return const SizedBox.shrink();
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Obx(() => Text(
//             'Score: ${controller.gameStats.value.currentScore}',
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           )),
//           IconButton(
//             icon: const Icon(Icons.pause, color: Colors.white),
//             onPressed: controller.pauseGame,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGameArea() {
//     return Obx(() => Stack(
//       children: [
//         // Column Dividers
//         ...List.generate(4, (index) {
//           return Positioned(
//             left: (Get.width / 4) * index,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 2,
//               color: Colors.white.withOpacity(0.2),
//             ),
//           );
//         }),
        
//         // Tiles
//         ...controller.tiles.map((tile) => _buildTile(tile)),
//       ],
//     ));
//   }

//   Widget _buildTile(TileModel tile) {
//     final tileWidth = Get.width / 4;
    
//     return Positioned(
//       left: (tileWidth * tile.column),
//       top: tile.position,
//       child: GestureDetector(
//         onTapDown: (_) => controller.onTileTap(tile),
//         child: Container(
//           width: tileWidth,
//           height: tileWidth,
//           decoration: BoxDecoration(
//             color: tile.isHit ? Colors.grey.withOpacity(0.5) : Colors.black,
//             border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           // Add visual feedback for the tile
//           child: Center(
//             child: Icon(
//               Icons.music_note,
//               color: tile.isHit ? Colors.grey : Colors.white,
//               size: tileWidth * 0.5,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPauseOverlay() {
//     return Container(
//       color: Colors.black54,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'PAUSED',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: controller.resumeGame,
//               child: const Text('Resume'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGameOverOverlay() {
//     return Container(
//       color: Colors.black87,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'GAME OVER',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Score: ${controller.gameStats.value.currentScore}',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Get.back(),
//                   child: const Text('Menu'),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: controller.startGame,
//                   child: const Text('Try Again'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStartOverlay() {
//     return Container(
//       color: Colors.black54,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Piano Tiles',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: controller.startGame,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 textStyle: const TextStyle(fontSize: 20),
//               ),
//               child: const Text('Start Game'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// } 