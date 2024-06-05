import 'package:get/get.dart';

/*Created By: Tushar Jethva
  Purpose: Below is conroller to manage video play and pause.
*/
class PlayPauseController extends GetxController {
  final RxBool _isPlaying = false.obs;

  bool get isPlaying => _isPlaying.value;

  set setIsPlaying(bool isPlay) {
    _isPlaying.value = isPlay;
  }

  final RxBool _isPlayingFull = false.obs;

  bool get isPlayingFull => _isPlayingFull.value;

  set setIsPlayingFull(bool isPlay) {
    _isPlayingFull.value = isPlay;
  }
}
