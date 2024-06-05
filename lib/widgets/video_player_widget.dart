import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/play_pause_controller.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_player/video_player.dart';

/* Created By: Tushar Jethva
   Purpose: It is extracted widget for video player
*/
class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  final double aspectRatio;
  const VideoPlayerWidget(
      {Key? key, required this.videoPath, required this.aspectRatio})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  final playPauseControllr = Get.put(PlayPauseController());
  final videoController = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    videoController.initialize(widget.videoPath);

  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    if (oldWidget.videoPath != widget.videoPath) {
      videoController.initialize(widget.videoPath);
    }

    super.didUpdateWidget(oldWidget);
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(builder: (videoController) {
      return videoController.videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: VideoPlayer(videoController.videoPlayerController),
            )
          : const Center(child: CircularProgressIndicator());
    });
  }
}
