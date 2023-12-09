import 'dart:math' show pi, max, min;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/helpers/extensions.dart';
import 'package:test_app/helpers/math.dart';

enum SpinnerState { loading, success, error }

const Duration animationResolvedCircle = Duration(milliseconds: 500);
const Duration animationResolvedWait = Duration(milliseconds: 200);
const Duration animationResolvedIcon = Duration(milliseconds: 600);

const Duration animationResolvedTotal = Duration(milliseconds: 1300);

class Spinner extends StatefulWidget {
  const Spinner({super.key, this.state = SpinnerState.loading});

  final SpinnerState state;

  @override
  State<Spinner> createState() => _SpinnerState();

  bool get resolved {
    return state != SpinnerState.loading;
  }
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  Duration totalTime = Duration.zero;
  Duration resolvedTime = Duration.zero;
  late final Ticker ticker;

  @override
  void didUpdateWidget(Spinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resolved && !widget.resolved) {
      /// Restart
      if (ticker.isActive) ticker.stop();
      ticker.start();
    }
    if (!oldWidget.resolved && widget.resolved) {
      /// Resolve
      resolvedTime = totalTime;
    }
  }

  @override
  void initState() {
    super.initState();
    ticker = createTicker((duration) {
      setState(() {
        totalTime = duration;
      });
      if (widget.resolved &&
          totalTime > resolvedTime + animationResolvedTotal) {
        ticker.stop();
      }
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
      painter: _SpinnerPainter(this, 4),
      child: const SizedBox.square(dimension: 48),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter(this.state, this.width);

  final _SpinnerState state;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint brush = Paint()
      ..color = const Color.fromARGB(255, 255, 00, 0)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double start = state.totalTime.inSecondsDouble * pi * .7;
    double length = min(state.totalTime.inSecondsDouble * pi, pi * 2 * .20);
    if (state.widget.resolved) {
      double stage = (state.totalTime - state.resolvedTime)
          .divide(animationResolvedCircle);
      length = max(length, clampedLerp(0, pi * 2, stage));
    }
    canvas.drawArc(
      rect.deflate(width / 2),
      start,
      length,
      false,
      brush,
    );
    if (state.widget.resolved) {
      double stage = inverseClampedLerp(
          0,
          animationResolvedIcon.inMicroseconds,
          (state.totalTime -
                  state.resolvedTime -
                  animationResolvedCircle -
                  animationResolvedWait)
              .inMicroseconds);
      if (stage > 0) {
        switch (state.widget.state) {
          case SpinnerState.success:
            paintTick(canvas, Offset(size.width / 2, size.height / 2), 24,
                brush, width, stage);
          case SpinnerState.error:
            paintCross(canvas, Offset(size.width / 2, size.height / 2), 8,
                brush, width, stage);
          default:
        }
      }
    }
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) => true;
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

void paintTick(Canvas canvas, Offset centerOffset, double width, Paint brush,
    double lineWidth, double step) {
  width = width - lineWidth;
  Offset pointA = Offset(width * -.5, width * .125) + centerOffset;
  Offset pointB = Offset(width * -.25, width * .375) + centerOffset;
  Offset pointC = Offset(width * .5, width * -.375) + centerOffset;
  canvas.drawLine(
    pointA,
    Offset.lerp(pointA, pointB, (step * 4).clamp(0, 1))!,
    brush,
  );
  if (step > .25) {
    canvas.drawLine(
      pointB,
      Offset.lerp(pointB, pointC, inverseClampedLerp(0.25, 1, step))!,
      brush,
    );
  }
}
