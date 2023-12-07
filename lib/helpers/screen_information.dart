import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenInformation extends StatelessWidget {
  const ScreenInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Column(
      children: [
        Text("Size in logical pixels: ${mq.size}"),
        Text("Device pixel ratio: ${mq.devicePixelRatio}"),
        MyWidget()
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // Find the nearest FlutterView
        RenderObject? renderObject = context.findRenderObject();

        if (renderObject == null) {
          return Text("loading");
        }
        RenderObject rObject = renderObject;
        while (rObject is! RenderView) {
          rObject = rObject.parent!;
        }
        FlutterView flutterView = rObject.flutterView;
        // Check if the renderObject is a RenderView and get the FlutterView

        // Your widget's UI
        return Text("${flutterView.physicalSize}");
      },
    );
  }
}
