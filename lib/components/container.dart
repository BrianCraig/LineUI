import 'package:flutter/widgets.dart';

import 'line_theme.dart';

Color backgroundColor(LineTheme theme) => theme.backgroundColor;

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key, required this.child, this.background = backgroundColor});

  final Widget child;
  final Color Function(LineTheme) background;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background(theme),
        borderRadius: BorderRadius.all(
          Radius.circular(theme.lineWidth * 4),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing),
        child: child,
      ),
    );
  }
}
