import 'package:flutter/material.dart'
    show StatefulWidget, State, Widget, Column, BuildContext, ValueKey;
import 'package:line_ui/helpers/extensions.dart';

import 'spacing.dart';
import 'text.dart';

class SingleSelector<T> extends StatefulWidget {
  const SingleSelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChange,
  });

  final List<T> items;
  final T? selectedItem;
  final void Function(T) onChange;

  @override
  State<SingleSelector> createState() => _SingleSelectorState<T>();
}

class _SingleSelectorState<T> extends State<SingleSelector<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items
          .map<Widget>(
            (e) => Text(
              e.toString(),
              key: ValueKey(e),
            ),
          )
          .intercalate(Spacing.half)
          .toList(),
    );
  }
}
