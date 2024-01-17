import 'package:flutter/material.dart';

import '../helpers/extensions.dart';
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

class _ButtonColors {
  final Color border, background, text;

  _ButtonColors(
      {required this.border, required this.background, required this.text});

  static _ButtonColors lerp(_ButtonColors begin, _ButtonColors end, double t) =>
      _ButtonColors(
        border: ColorExtensions.lerp(begin.border, end.border, t),
        background: ColorExtensions.lerp(begin.background, end.background, t),
        text: ColorExtensions.lerp(begin.text, end.text, t),
      );
}

class _ButtonColorsTween extends Tween<_ButtonColors> {
  _ButtonColorsTween({super.begin, super.end});

  @override
  _ButtonColors lerp(double t) {
    assert(begin != null);
    assert(end != null);
    return _ButtonColors.lerp(begin!, end!, t);
  }
}

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.style = ButtonStyle.primary,
  });

  final Widget child;
  final ButtonStyle style;
  final void Function()? onPressed;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool active = false;
  bool mouseOver = false;

  late Map<_ButtonStatus, _ButtonColors> themes;

  _ButtonStatus get status => switch ((active, mouseOver)) {
        (true, _) => _ButtonStatus.active,
        (false, false) => _ButtonStatus.inactive,
        (false, true) => _ButtonStatus.mouseOver,
      };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = LineTheme.of(context);
    final activeColor = switch (widget.style) {
      ButtonStyle.primary => theme.primaryColor,
      ButtonStyle.secondary => theme.secondaryColor,
    };
    themes = {
      _ButtonStatus.inactive: _ButtonColors(
        border: activeColor,
        background: theme.backgroundColor,
        text: theme.textColor,
      ),
      _ButtonStatus.mouseOver: _ButtonColors(
        border: activeColor,
        background:
            ColorExtensions.lerp(theme.backgroundColor, theme.textColor, 0.05),
        text: activeColor,
      ),
      _ButtonStatus.active: _ButtonColors(
        border: activeColor,
        background: activeColor,
        text: theme.backgroundColor,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          mouseOver = true;
        });
      },
      onExit: (event) {
        setState(() {
          mouseOver = false;
        });
      },
      child: GestureDetector(
        onTapDown: (details) {
          if (widget.onPressed case final onPressed?) {
            onPressed();
          }
          setState(() {
            active = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            active = false;
          });
        },
        onTapCancel: () {
          setState(() {
            active = false;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: TweenAnimationBuilder(
          tween: _ButtonColorsTween(begin: themes[status], end: themes[status]),
          duration: const Duration(milliseconds: 175),
          builder: (BuildContext context, _ButtonColors colors, _) =>
              DecoratedBox(
            decoration: BoxDecoration(
              color: colors.background,
              border: Border.all(
                color: colors.border,
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
              child: LineThemeProvider(
                theme: BasicLineTheme(
                  textColor: colors.text,
                  backgroundColor: colors.background,
                  primaryColor: theme.primaryColor,
                  secondaryColor: theme.secondaryColor,
                  accentColor: theme.accentColor,
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
