import 'package:get/get.dart';
import 'package:star_shine/game/audio_controller.dart';
import 'package:star_shine/game/game_controller.dart';

class PianoTilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudioController());
    Get.lazyPut(() => GameController(
      audioController: Get.find<AudioController>(),
    ));
  }
}