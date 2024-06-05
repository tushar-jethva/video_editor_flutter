import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/trimmer_controller.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_editing_app/utils/common_functions.dart';
import 'package:video_trimmer/video_trimmer.dart';

/* Created By: Tushar Jethva
   Purpose: It's trimmer view extracted widget
*/
class MyTrimmerView extends StatefulWidget {
  const MyTrimmerView({super.key});

  @override
  State<MyTrimmerView> createState() => _MyTrimmerViewState();
}

class _MyTrimmerViewState extends State<MyTrimmerView> {
  final trimmerContoller = Get.put(TrimmerController());
  final videoController = Get.put(VideoController());
  @override
  void initState() {
    super.initState();
    trimmerContoller.loadVideo();
  }

  @override
  void dispose() {
    super.dispose();
    trimmerContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoController.initialized
        ? TrimViewer(
            trimmer: trimmerContoller.trimmer,
            viewerHeight: getHeight(height: 0.08, context: context),
            viewerWidth: getWidth(width: 1, context: context),
            maxVideoLength: Duration(
                seconds: videoController.totalDuration.value.inSeconds),
            onChangeStart: (value) {
              trimmerContoller.startValue.value = value;
            },
            onChangeEnd: (value) {
              trimmerContoller.endValue.value = value;
            },
            showDuration: true,
            type: ViewerType.fixed,
          )
        : const CircularProgressIndicator();
  }
}
