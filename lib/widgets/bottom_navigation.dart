import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/bottom_navigation_controller.dart';
import 'package:video_editing_app/const/bottom_icons.dart';
import 'package:video_editing_app/utils/common_functions.dart';
import '../const/colors.dart';

/* Created By: Tushar Jethva
   Purpose: It is bottom navigation bar widget
*/
class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({
    super.key,
  });
  final bottomController = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: getHeight(height: 0.07, context: context),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomIcons.length, (index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      bottomController.setBottomIndex = index;
                    },
                    child: Image.asset(
                      bottomIcons[index],
                      color: bottomController.bottomIndex == index
                          ? primary
                          : white,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
