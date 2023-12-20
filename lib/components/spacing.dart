import 'package:flutter/material.dart';

import 'line_theme.dart';

class Spacing extends StatelessWidget {
  const Spacing({super.key, required this.ratio});

  final double ratio;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: LineTheme.of(context).spacing * ratio,
      );

  static const Spacing twice = Spacing(
    ratio: 2,
  );

  static const Spacing one = Spacing(
    ratio: 1,
  );

  static const Spacing half = Spacing(
    ratio: .5,
  );

  static const Spacing quarter = Spacing(
    ratio: .25,
  );
}
