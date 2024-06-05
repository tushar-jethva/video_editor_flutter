import 'dart:io';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_trimmer/video_trimmer.dart';

/*Created By: Tushar Jethva
  Purpose: Below controller is to manage trimming of video as per start and end duration.
*/
class TrimmerController extends GetxController {
  final Trimmer trimmer = Trimmer();

  RxDouble startValue = 0.0.obs;
  RxDouble endValue = 0.0.obs;

  final RxBool _progressVisibility = false.obs;

  final videoController = Get.put(VideoController());

  Future<String?> saveVideo() async {
    _progressVisibility.value = true;
    await trimmer
        .saveTrimmedVideo(
            startValue: startValue.value,
            endValue: endValue.value,
            onSave: (String? outputPath) {
              videoController.setvideoPath = outputPath!;
            })
        .then((value) {
      _progressVisibility.value = false;
    });

    return "";
  }

  void loadVideo() async{
    await trimmer.loadVideo(videoFile: File(videoController.videoPath));
  }
}
