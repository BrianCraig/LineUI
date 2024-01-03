import 'package:flutter/material.dart' hide Text;
import 'package:line_ui/helpers/extensions.dart';

import 'line_theme.dart';
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
  Widget itemToRow(T item) {
    return SelectorRow<T>(
      item: item,
      selected: widget.selectedItem == item,
      onToggle: () {
        widget.onChange(item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(
          color: theme.primaryColor,
          width: theme.lineWidth,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(theme.lineWidth * 4),
        ),
      ),
      child: Column(
        children:
            widget.items.map(itemToRow).intercalate(Spacing.half).toList(),
      ),
    );
  }
}

class SelectorRow<T> extends StatefulWidget {
  const SelectorRow(
      {super.key,
      required this.selected,
      required this.item,
      required this.onToggle});

  final bool selected;
  final T item;
  final void Function() onToggle;

  @override
  State<SelectorRow> createState() => _SelectorRowState<T>();
}

class _SelectorRowState<T> extends State<SelectorRow<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final selectedTheme = theme.copyWith(
        textColor: theme.primaryColor,
        backgroundColor:
            Color.lerp(theme.backgroundColor, theme.textColor, 0.2)!);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.lineWidth * 4,
            vertical: theme.lineWidth * 2,
          ),
          child: LineThemeProvider(
            theme: widget.selected ? selectedTheme : theme,
            child: Text(
              widget.item.toString(),
              key: ValueKey(widget.item),
            ),
          ),
        ),
      ),
    );
  }
}
