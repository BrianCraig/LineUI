import 'package:flutter/widgets.dart' hide Text;

import '../helpers/extensions.dart';
import '../helpers/math.dart';
import 'text.dart';
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
  Size? trackSize;
  late double lineWidth;
  bool grabbing = false;

  String valueToText(double value) => widget.valueToText != null
      ? widget.valueToText!(value)
      : value.toString();

  void updateValue(Offset lp) {
    Size? trackSize = this.trackSize;
    if (trackSize == null) return;

    double value = inverseClampedLerp(
        (lineWidth * 2.5), trackSize.width - (lineWidth * 2.5), lp.dx);

    widget.onChange(lerp(widget.from, widget.to, value));
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    lineWidth = theme.lineWidth;
    final Widget track = MouseRegion(
      cursor: grabbing ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
      child: GestureDetector(
        onPanDown: (details) {
          updateValue(details.localPosition);
          grabbing = true;
        },
        onPanEnd: (details) {
          setState(() {
            grabbing = false;
          });
        },
        onPanUpdate: (details) {
          updateValue(details.localPosition);
        },
        child: CustomPaint(
          painter: _LinearInputPainter(state: this, theme: theme),
        ),
      ),
    );

    return Row(
      children: [
        if (widget.showStart) ...[
          Text(valueToText(widget.from)),
          Spacing.half,
        ],
        Expanded(child: SizedBox(height: theme.lineWidth * 5, child: track)),
        if (widget.showEnd) ...[
          Spacing.half,
          Text(valueToText(widget.to)),
        ],
      ],
    );
  }
}

class _LinearInputPainter extends CustomPainter {
  const _LinearInputPainter({required this.state, required this.theme});

  final _LinearInputState state;
  final LineTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    state.trackSize = size;

    final lw = theme.lineWidth;
    final wd = state.widget;

    final Paint brush = Paint()
      ..color =
          ColorExtensions.lerp(theme.backgroundColor, theme.textColor, 0.2)
      ..strokeWidth = lw
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final x1 = lw * 2.5;
    final x2 = size.width - x1;
    final y = lw * 2.5;

    final xActive = lerp(x1, x2, wd.percentage);

    canvas.drawLine(Offset(x1, y), Offset(x2, y), brush);
    brush.color = theme.primaryColor;

    if (wd.value > wd.from) {
      canvas.drawLine(Offset(x1, y), Offset(xActive, y), brush);
    }

    canvas.drawCircle(Offset(xActive, y), lw * 2, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
