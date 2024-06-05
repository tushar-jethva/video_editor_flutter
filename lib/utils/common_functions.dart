import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//pickVideo
Future<List<String>> pickVideo() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.video, allowMultiple: false);

  List<String> filePaths = []; // Initialize the list outside the if block

  if (result != null) {
    for (PlatformFile file in result.files) {
      filePaths.add(file.path!); // Add the file path to the list
    }
  }

  return filePaths; // Return the list of file paths
}

//pickAudio
Future<String> pickAudio() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.audio, allowMultiple: false);

  if (result != null) {
    return result.files[0].path!;
  }
  return "";
}

double getHeight({required double height, required BuildContext context}) {
  return MediaQuery.of(context).size.height * height;
}

double getWidth({required double width, required BuildContext context}) {
  return MediaQuery.of(context).size.width * width;
}

Future<String> getDownloadsDirectoryPath() async {
  final directory = Directory('/Internal storage/Download');
  if (!await directory.exists()) {
    directory.create(recursive: true);
  }
  return directory.path;
}

Future<String> mergeAudioAndVideo(String audioPath, String videoPath,
    String outputPath, String fileName) async {
  Directory? directory = await getDownloadsDirectory();

  String outputPath =
      '${directory!.path}/$fileName${DateTime.now().toString()}.mp4';

  final command =
      '-i $videoPath -i $audioPath -c:v copy -c:a aac -strict experimental $outputPath';

  await FFmpegKit.executeAsync(command);
  return outputPath;
}
