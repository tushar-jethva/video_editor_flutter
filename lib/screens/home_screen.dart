import 'package:flutter/material.dart';
import 'package:video_editing_app/conrtoller/video_controller.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/screens/video_editing_screen.dart';
import 'package:video_editing_app/utils/common_functions.dart';
import 'package:get/get.dart';

/* Created By: Tushar Jethva
   Purpose: Below is home screen from where user can select video and proceeds for next
*/
class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            try {
              List<String> filePaths = await pickVideo();

              if (filePaths.isNotEmpty) {
                videoController.setvideoPath = filePaths[0];
                Get.to(MyVideoEditionScreen(
                  filePaths: filePaths,
                ));
              }
              // ignore: empty_catches
            } catch (e) {}
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo_rounded,
                size: 130,
                color: grey,
              ),
              Text(
                "Tap to open a video",
                style: TextStyle(color: grey, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
