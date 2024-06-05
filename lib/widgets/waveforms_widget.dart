import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_editing_app/conrtoller/audio_controller.dart';

class WaveformWidget extends StatefulWidget {
  final Duration duration;
  final Duration position;

  WaveformWidget({
    required this.duration,
    required this.position,
  });

  @override
  State<WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget> {
  final audioConroller = Get.put(AudioController());
  late List<double> samples;
  @override
  void initState() {
    super.initState();
    samples = [];
    parseData();
  }

  Future<void> parseData() async {
    final json = await rootBundle.loadString(audioConroller.audioPath);
    Map<String, dynamic> audioDataMap = {
      "json": json,
      "totalSamples": 1000,
    };
    final samplesData = await compute(loadparseJson, audioDataMap);
    // maxDuration in milliseconds
    await Future.delayed(const Duration(milliseconds: 200));
    samples = samplesData["samples"];
    setState(() {});
  }

  Map<String, dynamic> loadparseJson(Map<String, dynamic> audioDataMap) {
    String json = audioDataMap["json"];
    int totalSamples = audioDataMap["totalSamples"];

    Map<String, dynamic> parsedJson = jsonDecode(json);

    List<dynamic> samples = parsedJson['samples'];

    return {
      "samples": samples,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: (widget.position.inMilliseconds /
                  widget.duration.inMilliseconds) *
              MediaQuery.of(context).size.width,
          child: Container(
            width: 2,
            height: 100,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
