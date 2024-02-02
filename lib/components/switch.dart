import 'package:flutter/widgets.dart' hide Icon, Text;

import 'package:line_ui/components/components.dart';
import 'package:line_ui/helpers/extensions.dart';
import 'package:line_ui/helpers/math.dart';

class Switch extends StatefulWidget {
  const Switch({super.key, required this.value, this.onChange});

  final bool value;
  final void Function(bool value)? onChange;

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  bool grabbing = false;
  late double position;

  @override
  void initState() {
    position = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final theme = LineTheme.of(context);
    final lw = theme.lineWidth;
    final sp = theme.spacing;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.onChange != null) {
            widget.onChange!(!widget.value);
          }
        },
        onPanUpdate: (details) {
          setState(() {
            grabbing = true;
            position = inverseClampedLerp(
                lw + sp * .5, lw + sp * 2, details.localPosition.dx);
          });
        },
        onPanEnd: (details) {
          setState(() {
            grabbing = false;
            if (widget.onChange != null) {
              widget.onChange!(position > .5 ? true : false);
            }
          });
        },
        child: CustomPaint(
          painter: _SwitchPainter(state: this, theme: theme),
          child: SizedBox(
            width: theme.lineWidth * 2 + theme.spacing * 2.5,
            height: theme.lineWidth * 2 + theme.spacing,
          ),
        ),
      ),
    );
  }
}

class _SwitchPainter extends CustomPainter {
  const _SwitchPainter({required this.state, required this.theme});

  final _SwitchState state;
  final LineTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final double position = switch ((state.grabbing, state.widget.value)) {
      (true, _) => state.position,
      (false, true) => 1.0,
      _ => 0.0
    };

    final lw = theme.lineWidth;
    final sp = theme.spacing;
    final offColor =
        ColorExtensions.lerp(theme.backgroundColor, theme.textColor, 0.2);
    final onColor = theme.primaryColor;

    final outerColor = switch ((state.grabbing, state.widget.value)) {
      (true, _) => ColorExtensions.lerp(offColor, onColor, state.position),
      (false, true) => onColor,
      _ => offColor
    };

    final Paint brush = Paint()..color = outerColor;

    final outerR = Radius.circular(lw + sp / 2);
    canvas.drawDRRect(
        RRect.fromLTRBR(
          0,
          0,
          lw * 2 + sp * 2.5,
          lw * 2 + sp,
          outerR,
        ),
        RRect.zero,
        brush);

    brush.color = theme.backgroundColor;

    canvas.drawCircle(
      Offset(
        lw + sp / 2 + position * sp * 1.5,
        lw + sp / 2,
      ),
      theme.spacing / 2,
      brush,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
