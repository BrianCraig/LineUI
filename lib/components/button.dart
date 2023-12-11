import 'package:flutter/material.dart';

import 'line_theme.dart';

enum ButtonStyle {
  primary,
  secondary,
}

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.child,
    this.style = ButtonStyle.primary,
  });

  final Widget child;
  final ButtonStyle style;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);

    final Color style = switch (widget.style) {
      ButtonStyle.primary => theme.primaryColor,
      ButtonStyle.secondary => theme.secondaryColor,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(
          color: style.withOpacity(0.5),
          width: theme.lineWidth,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(theme.lineWidth * 4),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.lineWidth * 4,
          vertical: theme.lineWidth * 2,
        ),
        child: widget.child,
      ),
    );
  }
}
