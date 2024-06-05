import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/play_pause_controller.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/screens/full_screen.dart';
import 'package:video_editing_app/utils/common_functions.dart';

/* Created By: Tushar Jethva
   Purpose: It's extracted widget which has play, pause duration
*/
class MyBottomPlayWidget extends StatelessWidget {
  final String filePaths;
  MyBottomPlayWidget({super.key, required this.filePaths});
  final playPauseControllr = Get.put(PlayPauseController());
  final videoController = Get.put(VideoController());

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 20, sigmaY: 0), // Adjust blur intensity as needed
          child: Container(
            height: getHeight(height: 0.06, context: context),
            width: getWidth(width: 1, context: context),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    playPauseControllr.isPlaying
                        ? videoController.pause()
                        : videoController.play();

                    playPauseControllr.isPlaying
                        ? playPauseControllr.setIsPlaying = false
                        : playPauseControllr.setIsPlaying = true;
                  },
                  child: Obx(
                    () => playPauseControllr.isPlaying
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
                        _formatDuration(videoController.currentPosition.value),
                        style: const TextStyle(color: white),
                      ),
                    ),
                    const Gap(10),
                    Obx(
                      () => Text(
                        _formatDuration(videoController.totalDuration.value),
                        style: const TextStyle(color: grey),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    videoController.pause();
                    playPauseControllr.setIsPlaying = false;
                    Get.to(MyFullScreenVideoPlayerScreen(videoPath: filePaths));
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
        ),
      ),
    );
  }
}
