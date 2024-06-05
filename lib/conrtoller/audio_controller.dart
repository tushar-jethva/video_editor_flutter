import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

/*Created By: Tushar Jethva
  Purpose: Below is conroller to manage states of audio player.
*/
class AudioController extends GetxController {
  late AudioPlayer player = AudioPlayer();
  late PlayerState playerState;
  Rx<Duration> audioDuration = Rx<Duration>(Duration.zero);
  Rx<Duration> audioPosition = Rx<Duration>(Duration.zero);

  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;

  //Initialize audioPlayer by providing audio path
  Future<void> initialize(String audioPath) async {
    player.dispose();
    player = AudioPlayer();
    await player.setSource(DeviceFileSource(audioPath));

    playerState = player.state;
    player.getDuration().then(
          (value) => audioDuration.value = value!,
        );
    player.getCurrentPosition().then((value) => audioPosition.value = value!);
    _initStreams();
    update();
  }

  //Below functions listens duration and current position of audio
  void _initStreams() {
    durationSubscription = player.onDurationChanged.listen((duration) {
      audioDuration.value = duration;
    });

    positionSubscription = player.onPositionChanged.listen(
      (p) => audioPosition.value = p,
    );
  }

  final RxString _audioPath = "".obs;

  String get audioPath => _audioPath.value;

  set setAudioPath(String val) {
    _audioPath.value = val;
  }

  final RxBool _isPlayingAudio = false.obs;

  bool get isPlayingAudio => _isPlayingAudio.value;

  set setIsPlayingAudio(bool isPlay) {
    _isPlayingAudio.value = isPlay;
  }

  @override
  void onClose() {
    super.onClose();
    player.dispose();
  }
}
