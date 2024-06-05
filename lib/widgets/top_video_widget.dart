import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_editing_app/conrtoller/audio_controller.dart';
import 'package:video_editing_app/conrtoller/title_controller.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/const/ratios.dart';
import 'package:video_editing_app/utils/common_functions.dart';

/* Created By: Tushar Jethva
   Purpose: Below is header widget for aspect ration, title and save video
*/
class MyHeaderVideoWidget extends StatefulWidget {
  const MyHeaderVideoWidget({super.key});

  @override
  State<MyHeaderVideoWidget> createState() => _MyHeaderVideoWidgetState();
}

class _MyHeaderVideoWidgetState extends State<MyHeaderVideoWidget> {
  final videoController = Get.put(VideoController());

  final audioConroller = Get.put(AudioController());

  final titleConroller = Get.put(TitleController());

  Future<void> requestStoragePermission(BuildContext context) async {
    var status = await Permission.storage.status;
    var statusMediaLocation = await Permission.accessMediaLocation.status;
    var statusExternalStorage = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    if (!statusMediaLocation.isGranted) {
      statusMediaLocation = await Permission.accessMediaLocation.request();
    }

    if (!statusExternalStorage.isGranted) {
      statusExternalStorage = await Permission.manageExternalStorage.request();
    }

    if (statusExternalStorage.isGranted) {
      // Handle denied permission
       await mergeAudioAndVideo(
          videoController.videoPath,
          audioConroller.audioPath,
          "/download/hello.mp4",
          titleConroller.title);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Saved")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Not Saved")));
    }
  }

  showCurrentDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: getHeight(height: 0.25, context: context),
              width: getWidth(width: 0.8, context: context),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Change Title",
                    style: TextStyle(
                      color: primary,
                      fontSize: 20,
                    ),
                  ),
                  Gap(getHeight(height: 0.02, context: context)),
                  TextField(
                    controller: titleConroller.titleController,
                    decoration: InputDecoration(
                      hintText: "Untitled",
                      hintStyle: const TextStyle(color: grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primary)),
                    ),
                  ),
                  Gap(getHeight(height: 0.011, context: context)),
                  ElevatedButton(
                    onPressed: () {
                      titleConroller.setTitle();
                      Navigator.pop(context);
                    },
                    child: const Text("Rename"),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(height: 0.07, context: context),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.2, 2],
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.0),
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => DropdownButton<double>(
                      isExpanded: false,
                      style: const TextStyle(
                          color: grey, fontWeight: FontWeight.bold),
                      borderRadius: BorderRadius.circular(15),
                      underline: const SizedBox(),
                      dropdownColor: const Color.fromARGB(248, 255, 255, 255),
                      elevation: 10,
                      icon: Transform.rotate(
                        angle: 29.8,
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: iconGreyColor,
                          size: 15,
                        ),
                      ),
                      value: videoController.aspectRatio,
                      items: aspectRatios.map((aspectRatio) {
                        return DropdownMenuItem<double>(
                          value: aspectRatio['ratio'],
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Text(
                              aspectRatio['label'],
                              style:
                                  const TextStyle(color: primary, fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        videoController.setAspectRatio = value!;
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Video Title / ",
                    style: TextStyle(color: iconGreyColor),
                  ),
                  InkWell(
                    onTap: () {
                      showCurrentDialog(context);
                    },
                    child: Obx(
                      () => Text(
                        titleConroller.title,
                        style:const TextStyle(color: white),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      requestStoragePermission(context);
                    },
                    child: const Icon(
                      Icons.save,
                      color: primary,
                    ),
                  ),
                  const Gap(20),
                  InkWell(
                      onTap: () {},
                      child: Transform.rotate(
                        angle: 29.8,
                        child: const Icon(
                          Icons.logout,
                          color: primary,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
