import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/audio_controller.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/utils/common_functions.dart';
import 'package:video_editing_app/widgets/icon_container.dart';
import 'package:path/path.dart' as path;

/* Created By: Tushar Jethva
   Purpose: Below is extracted widget to select music
*/
class MySelectAudioWidget extends StatelessWidget {
  const MySelectAudioWidget({super.key});
  String extractAudioName(String audioPath) {
    // Use the 'basename' function from the 'path' package to get the filename
    String audioName = path.basename(audioPath);
    return audioName;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      builder: (audioController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    String audio = await pickAudio();
                    if (audio != "") {
                      audioController.setAudioPath = audio;
                    }
                    await audioController.initialize(audioController.audioPath);
                  },
                  icon: const MyIconContainer(),
                ),
                Obx(
                  () => audioController.audioPath.isNotEmpty
                      ? Obx(
                          () => Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black45.withOpacity(0.3)),
                              child: Text(
                                maxLines: 1,
                                extractAudioName(audioController.audioPath),
                                style: const TextStyle(
                                    color: white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black45.withOpacity(0.3)),
                          child: const Text(
                            maxLines: 1,
                            "Choose Music!",
                            style: TextStyle(
                                color: white, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                ),
                Obx(
                  () => audioController.audioPath.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            audioController.setAudioPath = "";
                            audioController.initialize("");
                            audioController.audioDuration.value = Duration.zero;
                            audioController.audioPosition.value = Duration.zero;
                            audioController.setIsPlayingAudio = false;
                          },
                          icon: const Icon(
                            Icons.close,
                            color: white,
                          ))
                      : const SizedBox(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
