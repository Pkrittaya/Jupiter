import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class GifImageStopFrame extends StatefulWidget {
  const GifImageStopFrame({
    Key? key,
    required this.image,
    required this.isLoop,
    required this.frameLength,
    required this.frameStop,
    this.width,
    this.height,
  }) : super(key: key);
  final ImageProvider image;
  final double? width;
  final double? height;
  final bool isLoop;
  final double frameLength;
  final double frameStop;

  @override
  GifImageStopFrameState createState() => GifImageStopFrameState();
}

class GifImageStopFrameState extends State<GifImageStopFrame>
    with TickerProviderStateMixin {
  late final GifController controller;

  @override
  void initState() {
    try {
      controller = GifController(vsync: this);
      controller.repeat(
        min: 0,
        max: controller.upperBound,
        period: const Duration(milliseconds: 5000),
      );
    } catch (e) {}
    super.initState();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoop) {
      controller.value = 1;
      controller.stop();
    } else {
      controller.repeat(
        min: 0,
        max: controller.upperBound,
        period: const Duration(milliseconds: 5000),
      );
    }
    return Gif(
      fps: 60,
      controller: controller,
      image: widget.image,
      autostart: Autostart.loop,
    );
  }
}
