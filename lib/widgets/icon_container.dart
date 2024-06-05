import 'package:flutter/material.dart';
import 'package:video_editing_app/const/colors.dart';
import 'package:video_editing_app/utils/common_functions.dart';

/* Created By: Tushar Jethva
   Purpose: Icon container which make container with icon with shape circle
*/
class MyIconContainer extends StatelessWidget {
  const MyIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getHeight(height: 0.03, context: context),
      width: getWidth(width: 0.07, context: context),
      decoration: const BoxDecoration(color: primary, shape: BoxShape.circle),
      child: const Icon(
        Icons.music_note,
        color: white,
      ),
    );
  }
}
