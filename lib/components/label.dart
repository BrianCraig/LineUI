import 'package:flutter/widgets.dart' hide Text;

import 'text.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static Label text(String text) => Label(child: Text(text));
}
