import 'package:flutter/material.dart';

class PixelRatio extends StatelessWidget {
  const PixelRatio({super.key, required this.child, this.devicePixelRatio = 3});
  final Widget child;
  final double devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(devicePixelRatio: devicePixelRatio),
      child: child,
    );
  }
}
