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
  late AnimationController animation;
  Animation<Color?>? colorAnimation;

  _ButtonStatus get status => switch ((active, mouseOver)) {
        (true, _) => _ButtonStatus.active,
        (false, false) => _ButtonStatus.inactive,
        (false, true) => _ButtonStatus.mouseOver,
      };

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void setStateWithAnimation(void Function() function, LineTheme theme) {
    setState(() {
      _ButtonStatus initialStatus = status;
      function();
      if (initialStatus != status) {
        colorAnimation = ColorTween(
          begin: colorAnimation!.value,
          end: calculateBorderColor(theme),
        ).animate(animation);
        animation.forward(from: 0);
      }
    });
  }

  Color calculateBorderColor(LineTheme theme) {
    final Color style = switch (widget.style) {
      ButtonStyle.primary => theme.primaryColor,
      ButtonStyle.secondary => theme.secondaryColor,
    };

    return switch (status) {
      _ButtonStatus.inactive => style.withOpacity(0.5),
      _ButtonStatus.active => style,
      _ButtonStatus.mouseOver => style.withOpacity(0.7),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    Color borderColor = calculateBorderColor(theme);

    colorAnimation ??= ColorTween(
      begin: borderColor,
      end: borderColor,
    ).animate(animation);

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
          setStateWithAnimation(() {
            mouseOver = true;
          }, theme)
        },
        onExit: (event) => {
          setStateWithAnimation(() {
            mouseOver = false;
          }, theme)
        },
        child: GestureDetector(
          onTapDown: (details) => {
            setStateWithAnimation(() {
              active = true;
            }, theme)
          },
          onTapUp: (details) => {
            setStateWithAnimation(() {
              active = false;
            }, theme)
          },
          onTapCancel: () => {
            setStateWithAnimation(() {
              active = false;
            }, theme)
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
