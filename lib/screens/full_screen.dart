import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/play_pause_controller.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/utils/common_functions.dart';
import 'package:video_player/video_player.dart';

/* Created By: Tushar Jethva
   Purpose: Below is to show video in full screen
*/
class MyFullScreenVideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const MyFullScreenVideoPlayerScreen({super.key, required this.videoPath});
  @override
  State<MyFullScreenVideoPlayerScreen> createState() =>
      _FullScreenVideoPlayerScreenState();
}

class _FullScreenVideoPlayerScreenState
    extends State<MyFullScreenVideoPlayerScreen> {
  final fullVideoController = Get.put(VideoController());
  final playPauseControllr = Get.put(PlayPauseController());
  final videoConroller = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    fullVideoController.initializeFull(videoConroller.videoPath);
    playPauseControllr.setIsPlayingFull = true;
  }

  @override
  void didUpdateWidget(covariant MyFullScreenVideoPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      fullVideoController.initializeFull(videoConroller.videoPath);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: getHeight(height: 1, context: context),
              width: getWidth(width: 1, context: context),
            ),
            Center(
              child: AspectRatio(
                aspectRatio: getWidth(width: 1, context: context) /
                    getHeight(height: 1, context: context),
                child: GetBuilder<VideoController>(
                    builder: (fullVideoController) => VideoPlayer(
                        fullVideoController.fulllVideoPlayerController)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(160, 37, 37, 37),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              height: getHeight(height: 0.06, context: context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      playPauseControllr.isPlayingFull
                          ? fullVideoController.pauseFull()
                          : fullVideoController.playFull();

                      playPauseControllr.isPlayingFull
                          ? playPauseControllr.setIsPlayingFull = false
                          : playPauseControllr.setIsPlayingFull = true;
                    },
                    child: Obx(
                      () => playPauseControllr.isPlayingFull
                          ? const Icon(
                              Icons.pause,
                              color: white,
                              size: 30,
                            )
                          : const Icon(
                              Icons.play_arrow,
                              color: white,
                              size: 30,
                            ),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          _formatDuration(
                              fullVideoController.currentFullPosition.value),
                          style: const TextStyle(color: white),
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => Text(
                          _formatDuration(
                              fullVideoController.totalFullDuration.value),
                          style: const TextStyle(color: grey),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      fullVideoController.pauseFull();
                      playPauseControllr.setIsPlayingFull = false;
                      Get.back();
                    },
                    child: const Icon(
                      Icons.aspect_ratio_rounded,
                      color: white,
                      size: 27,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
