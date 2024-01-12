import 'package:flutter/widgets.dart' hide Text;

import '../helpers/extensions.dart';
import '../helpers/math.dart';
import 'label.dart';
import 'text.dart';
import 'line_theme.dart';
import 'spacing.dart';

enum LinearInputLabel {
  none,
  top,
  bottom,
}

String defaultValueToText(double value) =>
    switch (value == value.roundToDouble()) {
      false => value.toStringAsFixed(3),
      true => value.toString(),
    };

class LinearInput extends StatefulWidget {
  const LinearInput({
    super.key,
    this.from = 0,
    this.to = 1,
    this.showStart = true,
    this.showEnd = true,
    this.label = LinearInputLabel.top,
    required this.value,
    required this.onChange,
    this.valueToText = defaultValueToText,
  })  : assert(
          from < to,
          '`from` must be smaller than `to`',
        ),
        assert(
          (from <= value) && (value <= to),
          '`value` must be between `from` and `to`',
        ),
        assert(
          (label != LinearInputLabel.bottom),
          '`LinearInputLabel.bottom` not implemented',
        );

  final double from, to, value;
  final bool showStart, showEnd;
  final void Function(double) onChange;
  final String Function(double) valueToText;
  final LinearInputLabel label;

  double get percentage => inverseClampedLerp(from, to, value);

  @override
  State<LinearInput> createState() => _LinearInputState();
}

class _LinearInputState extends State<LinearInput> {
  Size trackSize = const Size(1, 1);
  late double lineWidth;
  bool grabbing = false;
  bool hover = false;

  void updateValue(Offset lp) {
    Size trackSize = this.trackSize;

    double value = inverseClampedLerp(
        (lineWidth * 2.5), trackSize.width - (lineWidth * 2.5), lp.dx);

    widget.onChange(lerp(widget.from, widget.to, value));
  }

  double xPosFromValue(double value) {
    final x1 = lineWidth * 2.5;
    final x2 = trackSize.width - x1;

    return lerp(x1, x2, inverseClampedLerp(widget.from, widget.to, value));
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    lineWidth = theme.lineWidth;

    Widget child = CustomPaint(
      painter: _LinearInputPainter(state: this, theme: theme),
    );

    if (widget.label != LinearInputLabel.none && (hover || grabbing)) {
      child = Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: child),
          Positioned(
            top: -26,
            left: -100 + xPosFromValue(widget.value),
            child: SizedBox(
                width: 200,
                child: Center(
                    child: Label.text(widget.valueToText(widget.value)))),
          ),
        ],
      );
    }

    final Widget track = MouseRegion(
      cursor: grabbing ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
      onEnter: (_) {
        setState(() {
          hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          hover = false;
        });
      },
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
        child: child,
      ),
    );

    return Row(
      children: [
        if (widget.showStart) ...[
          Text(widget.valueToText(widget.from)),
          Spacing.half,
        ],
        Expanded(child: SizedBox(height: theme.lineWidth * 5, child: track)),
        if (widget.showEnd) ...[
          Spacing.half,
          Text(widget.valueToText(widget.to)),
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
