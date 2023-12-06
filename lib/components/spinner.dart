import 'dart:math' show pi;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/helpers/extensions.dart';

enum SpinnerState { loading, success, error }

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  Duration totalTime = Duration.zero;
  late final Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((duration) {
      setState(() {
        totalTime = duration;
      });
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpinnerPainter(
          totalTime.divide(const Duration(seconds: 2)).fractional(),
          Curves.decelerate,
          4),
      child: const SizedBox.square(dimension: 48),
    );
  }
}

class SpinnerPainter extends CustomPainter {
  /// Reccomended curve: Curves.decelerate
  SpinnerPainter(this.value, this.curve, this.width);

  final double value;
  final Curve curve;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint brush = Paint()
      ..color = const Color.fromARGB(255, 255, 00, 0)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double start = curve.flipped.transform(value);
    double end = curve.transform(value);
    double initial = -pi / 2;
    canvas.drawArc(
      rect.deflate(width / 2),
      (pi * 2 * start) + initial,
      pi * 2 * (end - start),
      false,
      brush,
    );
    paintCross(canvas, Offset(size.width / 2, size.height / 2), 8, brush, width,
        value);
  }

  @override
  bool shouldRepaint(SpinnerPainter oldDelegate) => true;
}

void paintCross(Canvas canvas, Offset centerOffset, double width, Paint brush,
    double lineWidth, double step) {
  double distance = width - (lineWidth / 2);
  Offset start = centerOffset + Offset(-distance, distance);
  Offset end = centerOffset + Offset(distance, -distance);
  canvas.drawLine(
    start,
    Offset.lerp(start, end, (step * 2).clamp(0, 1))!,
    brush,
  );
  if (step > .5) {
    start = centerOffset + Offset(-distance, -distance);
    end = centerOffset + Offset(distance, distance);
    canvas.drawLine(
      start,
      Offset.lerp(start, end, ((step * 2) - 1).clamp(0, 1))!,
      brush,
    );
  }
}
