import 'package:flutter/material.dart' show Icon, Icons;
import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_ui/components/linear_input.dart';

import '../components/components.dart';

extension ToStringMedia on Duration {
  String toStringMedia() {
    var microseconds = inMicroseconds;
    var sign = "";
    var negative = microseconds < 0;

    var hours = microseconds ~/ Duration.microsecondsPerHour;
    microseconds = microseconds.remainder(Duration.microsecondsPerHour);

    if (negative) {
      hours = 0 - hours;
      microseconds = 0 - microseconds;
      sign = "-";
    }

    var minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

    var minutesPadding = minutes < 10 ? "0" : "";

    var seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    var secondsPadding = seconds < 10 ? "0" : "";

    return "$sign$hours:"
        "$minutesPadding$minutes:"
        "$secondsPadding$seconds";
  }
}

final basicLinearInputStateProvider = StateProvider<double>(
  (ref) => 0.2,
);

final songLinearInputStateProvider = StateProvider<double>(
  (ref) => 12,
);

class LinearInputScreen extends ConsumerWidget {
  const LinearInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'LinearInput Component',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
                showStart: false,
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
                showEnd: false,
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
                showStart: false,
                showEnd: false,
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(songLinearInputStateProvider),
                onChange: (value) {
                  ref.read(songLinearInputStateProvider.notifier).state = value;
                },
                from: 0,
                to: 200,
                valueToText: (seconds) =>
                    Duration(seconds: seconds.toInt()).toStringMedia(),
              ),
            ),
            Spacing.one,
            const SizedBox(
              width: 320,
              child: AnimatedLineDemo(),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLineDemo extends StatefulWidget {
  const AnimatedLineDemo({super.key});

  @override
  State<AnimatedLineDemo> createState() => _AnimatedLineDemoState();
}

class _AnimatedLineDemoState extends State<AnimatedLineDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  Animation<Color?>? colorAnimation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
      lowerBound: 0,
      upperBound: 10,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return Row(
      children: [
        TapRegion(
          onTapInside: (event) {
            if (animation.isCompleted) {
              animation.forward(from: 0);
            } else if (animation.isAnimating) {
              animation.stop();
              setState(() {});
            } else {
              animation.forward();
            }
          },
          child: Icon(
            animation.isAnimating
                ? Icons.pause_outlined
                : Icons.play_arrow_outlined,
            color: theme.textColor,
          ),
        ),
        Spacing.half,
        Expanded(
          child: LinearInput(
            value: animation.value,
            onChange: (value) {
              final isAnim = animation.isAnimating;
              animation.value = value;
              if (isAnim) {
                animation.forward();
              }
            },
            from: 0,
            to: 10,
            showStart: false,
            showEnd: false,
            valueToText: (seconds) =>
                Duration(seconds: seconds.toInt()).toStringMedia(),
          ),
        ),
      ],
    );
  }
}
