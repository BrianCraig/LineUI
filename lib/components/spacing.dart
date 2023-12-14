import 'package:flutter/material.dart';

import 'line_theme.dart';

class Spacing extends StatelessWidget {
  const Spacing({super.key, required this.ratio});

  final double ratio;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: LineTheme.of(context).spacing * ratio,
      );

  static Spacing get twice => const Spacing(
        ratio: 2,
      );

  static Spacing get one => const Spacing(
        ratio: 1,
      );

  static Spacing get half => const Spacing(
        ratio: .5,
      );

  static Spacing get quarter => const Spacing(
        ratio: .25,
      );
}
