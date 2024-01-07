import 'package:flutter/widgets.dart';

import '../helpers/math.dart';
import 'line_theme.dart';
import 'spacing.dart';

class LinearInput extends StatefulWidget {
  const LinearInput({
    super.key,
    this.from = 0,
    this.to = 1,
    this.showStart = true,
    this.showEnd = true,
    required this.value,
    required this.onChange,
    this.valueToText,
  })  : assert(
          from < to,
          '`from` must be smaller than `to`',
        ),
        assert(
          (from <= value) && (value <= to),
          '`value` must be between `from` and `to`',
        );

  final double from, to, value;
  final bool showStart, showEnd;
  final void Function(double) onChange;
  final String Function(double)? valueToText;

  double get percentage => inverseClampedLerp(from, to, value);

  @override
  State<LinearInput> createState() => _LinearInputState();
}

class _LinearInputState extends State<LinearInput> {
  String valueToText(double value) => widget.valueToText != null
      ? widget.valueToText!(value)
      : value.toString();

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final Widget track = CustomPaint(
      painter: _LinearInputPainter(state: this, theme: theme),
    );

    return Row(
      children: [
        if (widget.showStart) ...[
          Text(valueToText(widget.from)),
          Spacing.half,
        ],
        Expanded(child: SizedBox(height: theme.lineWidth * 3, child: track)),
        if (widget.showEnd) ...[
          Spacing.half,
          Text(valueToText(widget.to)),
        ],
      ],
    );
  }
}

class _LinearInputPainter extends CustomPainter {
  const _LinearInputPainter(
      {super.repaint, required this.state, required this.theme});

  final _LinearInputState state;
  final LineTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final lw = theme.lineWidth;
    final wd = state.widget;

    final Paint brush = Paint()
      ..color = Color.lerp(theme.backgroundColor, theme.textColor, 0.2)!
      ..strokeWidth = lw
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final x1 = lw * .5;
    final x2 = size.width - (lw * .5);
    final y = lw * 1.5;

    canvas.drawLine(Offset(x1, y), Offset(x2, y), brush);

    if (wd.value > wd.from) {
      brush.color = theme.primaryColor;

      canvas.drawLine(
          Offset(x1, y), Offset(lerp(x1, x2, wd.percentage), y), brush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
