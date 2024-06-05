import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/audio_controller.dart';
import 'package:video_editing_app/conrtoller/bottom_navigation_controller.dart';
import 'package:video_editing_app/conrtoller/play_pause_controller.dart';
import 'package:video_editing_app/conrtoller/trimmer_controller.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/utils/common_functions.dart';
import 'package:video_editing_app/widgets/bottom_navigation.dart';
import 'package:video_editing_app/widgets/bottom_video_widget.dart';
import 'package:video_editing_app/widgets/select_audio_widget.dart';
import 'package:video_editing_app/widgets/top_video_widget.dart';
import 'package:video_editing_app/widgets/trimmer_widget.dart';
import 'package:video_editing_app/widgets/video_player_widget.dart';

/*Created By: Tushar Jethva
  Purpose: It is video editing screen where user can perfom various given functionalities
*/
class MyVideoEditionScreen extends StatefulWidget {
  final List<String> filePaths;
  const MyVideoEditionScreen({super.key, required this.filePaths});

  @override
  State<MyVideoEditionScreen> createState() => _MyVideoEditionScreenState();
}

class _MyVideoEditionScreenState extends State<MyVideoEditionScreen> {
  final playPauseControllr = Get.put(PlayPauseController());
  final videoController = Get.put(VideoController());
  final bottomController = Get.put(BottomNavigationController());
  final audioController = Get.put(AudioController());
  final trimmerController = Get.put(TrimmerController());

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }



  @override
  void dispose() {
    super.dispose();
    audioController.player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    height: getHeight(height: 1, context: context),
                    width: getWidth(width: 1, context: context),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 20, 20, 20)),
                  ),
                  Center(
                    child: Obx(
                      () {
                        return VideoPlayerWidget(
                            videoPath: videoController.videoPath,
                            aspectRatio: videoController.aspectRatio);
                      },
                    ),
                  ),
                  MyBottomPlayWidget(filePaths: videoController.videoPath),
                  MyHeaderVideoWidget()
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView(children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.02, 0.6, 1],
                      colors: [lightPurple, darkPurple, tPurple],
                    ),
                  ),
                  child: Column(
                    children: [
                      Gap(getHeight(height: 0.03, context: context)),
                      const MyTrimmerView(),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                await trimmerController.saveVideo();
                              },
                              child: const Text("Save")),
                        ),
                      ),
                      const MySelectAudioWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              _formatDuration(
                                  audioController.audioPosition.value),
                              style: const TextStyle(color: white),
                            ),
                          ),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                audioController.isPlayingAudio
                                    ? audioController.player.pause()
                                    : audioController.player.resume();

                                audioController.isPlayingAudio
                                    ? audioController.setIsPlayingAudio = false
                                    : audioController.setIsPlayingAudio = true;
                              },
                              icon: audioController.isPlayingAudio
                                  ? const Icon(
                                      Icons.pause,
                                      color: primary,
                                    )
                                  : const Icon(
                                      Icons.play_arrow,
                                      color: primary,
                                    ),
                            ),
                          ),
                          Obx(() => Text(
                                _formatDuration(
                                    audioController.audioDuration.value),
                                style: const TextStyle(color: white),
                              )),
                          Gap(getHeight(height: 0.05, context: context)),
                        ],
                      ),
                      Gap(getHeight(height: 0.06, context: context)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MyBottomNavigationBar(),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
