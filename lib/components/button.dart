import 'package:flutter/material.dart';

import 'line_theme.dart';

enum _ButtonStatus {
  inactive,
  active,
  mouseOver,
}

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

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  bool active = false;
  bool mouseOver = false;

  _ButtonStatus get status => switch ((active, mouseOver)) {
        (true, _) => _ButtonStatus.active,
        (false, false) => _ButtonStatus.inactive,
        (false, true) => _ButtonStatus.mouseOver,
      };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);

    final Color style = switch (widget.style) {
      ButtonStyle.primary => theme.primaryColor,
      ButtonStyle.secondary => theme.secondaryColor,
    };

    Color borderColor = switch (status) {
      _ButtonStatus.inactive => style.withOpacity(0.5),
      _ButtonStatus.active => style,
      _ButtonStatus.mouseOver => style.withOpacity(0.7),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(
          color: borderColor,
          width: theme.lineWidth,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(theme.lineWidth * 4),
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => {
          setState(() {
            mouseOver = true;
          })
        },
        onExit: (event) => {
          setState(() {
            mouseOver = false;
          })
        },
        child: GestureDetector(
          onTapDown: (details) => {
            setState(() {
              active = true;
            })
          },
          onTapUp: (details) => {
            setState(() {
              active = false;
            })
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.lineWidth * 4,
              vertical: theme.lineWidth * 2,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
