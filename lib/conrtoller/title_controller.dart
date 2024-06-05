import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*Created By: Tushar Jethva
  Purpose: Below conroller to update video title as user entered.
*/
class TitleController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  RxString _title = "Untitled".obs;

  String get title => _title.value;

  void setTitle() {
    _title.value = titleController.text;
  }
}
