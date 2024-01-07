import 'package:flutter/widgets.dart';

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

  @override
  State<LinearInput> createState() => _LinearInputState();
}

class _LinearInputState extends State<LinearInput> {
  String valueToText(double value) => widget.valueToText != null
      ? widget.valueToText!(value)
      : value.toString();

  @override
  Widget build(BuildContext context) {
    final Widget track = Text('track');

    return Row(
      children: [
        if (widget.showStart) ...[
          Text(valueToText(widget.from)),
          Spacing.half,
        ],
        Expanded(child: track),
        if (widget.showEnd) ...[
          Text(valueToText(widget.to)),
          Spacing.half,
        ],
      ],
    );
  }
}
