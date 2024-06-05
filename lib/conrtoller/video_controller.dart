import 'dart:io';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/audio_controller.dart';
import 'package:video_editing_app/conrtoller/play_pause_controller.dart';
import 'package:video_player/video_player.dart';

/*Created By: Tushar Jethva
  Purpose: Below conroller is to manage video player states.
*/
class VideoController extends GetxController {
  late VideoPlayerController _videoPlayerController;
  Rx<Duration> currentPosition = Rx<Duration>(Duration.zero);
  Rx<Duration> totalDuration = Rx<Duration>(Duration.zero);

  //Below video_player_controller is for editor screen
  VideoPlayerController get videoPlayerController => _videoPlayerController;

  final audioController = Get.put(AudioController());
  final playPauseController = Get.put(PlayPauseController());

  //Initialize video player by providing selected path
  void initialize(String path) {
    _videoPlayerController = VideoPlayerController.file(File(path))
      ..addListener(() {
        currentPosition.value = _videoPlayerController.value.position;
      })
      ..initialize().then((_) {
        update();
        totalDuration.value = _videoPlayerController.value.duration;
        videoPlayerController.play();
        playPauseController.setIsPlaying = true;
      });
  }

  void play() {
    _videoPlayerController.play();
    update();
  }

  void pause() {
    _videoPlayerController.pause();
    update();
  }

  @override
  void onClose() {
    _videoPlayerController.dispose();
    _fullVideoPlayerController.dispose();
    super.onClose();
  }

  //Below video_player_controller is for full screen video player
  late VideoPlayerController _fullVideoPlayerController;
  Rx<Duration> currentFullPosition = Rx<Duration>(Duration.zero);
  Rx<Duration> totalFullDuration = Rx<Duration>(Duration.zero);
  VideoPlayerController get fulllVideoPlayerController =>
      _fullVideoPlayerController;

  void initializeFull(String path) {
    _fullVideoPlayerController = VideoPlayerController.file(File(path))
      ..addListener(() {
        currentFullPosition.value = _fullVideoPlayerController.value.position;
      })
      ..initialize().then((_) {
        update();
        playFull();
        totalFullDuration.value = _fullVideoPlayerController.value.duration;
      });
  }

  void playFull() {
    _fullVideoPlayerController.play();
    update();
  }

  void pauseFull() {
    _fullVideoPlayerController.pause();
    update();
  }

  //Below code is to manage aspect ratios
  final RxDouble _aspectRation = RxDouble(16 / 9);

  double get aspectRatio => _aspectRation.value;

  set setAspectRatio(double val) {
    _aspectRation.value = val;
  }

  //Below code is to manage video path
  final RxString _videoPath = "".obs;

  String get videoPath => _videoPath.value;

  set setvideoPath(String val) {
    _videoPath.value = val;
  }
}
