import 'package:flutter/material.dart' hide Text;
import 'package:line_ui/helpers/extensions.dart';

import 'line_theme.dart';
import 'spacing.dart';
import 'text.dart';

abstract interface class StateLineTheme {
  LineTheme get base;
  LineTheme get hover;
  LineTheme get active;
}

class BasicStateLineTheme implements StateLineTheme {
  BasicStateLineTheme({
    required this.base,
    required this.hover,
    required this.active,
  });

  @override
  final LineTheme base;
  @override
  final LineTheme hover;
  @override
  final LineTheme active;
}

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
  State<SingleSelector<T>> createState() => _SingleSelectorState<T>();
}

class _SingleSelectorState<T> extends State<SingleSelector<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);

    final stateThemes = BasicStateLineTheme(
      base: theme,
      hover: LineTheme.copyTheme(
        theme,
        textColor: theme.primaryColor,
        backgroundColor:
            Color.lerp(theme.backgroundColor, theme.textColor, 0.05)!,
      ),
      active: LineTheme.copyTheme(
        theme,
        textColor: theme.backgroundColor,
        backgroundColor: theme.primaryColor,
      ),
    );

    Widget itemToRow(T item) {
      return SelectorRow<T>(
        item: item,
        selected: widget.selectedItem == item,
        onToggle: () {
          widget.onChange(item);
        },
        themes: stateThemes,
      );
    }

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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.lineWidth,
          vertical: theme.lineWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacing.quarter,
            ...widget.items.map(itemToRow).intercalate(Spacing.quarter),
            Spacing.quarter,
          ],
        ),
      ),
    );
  }
}

class SelectorRow<T> extends StatefulWidget {
  const SelectorRow({
    super.key,
    required this.selected,
    required this.item,
    required this.onToggle,
    required this.themes,
  });

  final StateLineTheme themes;
  final bool selected;
  final T item;
  final void Function() onToggle;

  @override
  State<SelectorRow> createState() => _SelectorRowState<T>();
}

class _SelectorRowState<T> extends State<SelectorRow<T>> {
  bool mouseOver = false;

  @override
  Widget build(BuildContext context) {
    final theme = switch ((widget.selected, mouseOver)) {
      (true, _) => widget.themes.active,
      (false, true) => widget.themes.hover,
      (false, false) => widget.themes.base,
    };

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          mouseOver = true;
        });
      },
      onExit: (event) {
        setState(() {
          mouseOver = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onToggle,
        child: LineThemeProvider(
          theme: theme,
          child: SelectorRowView<T>(
            item: widget.item,
          ),
        ),
      ),
    );
  }
}

class SelectorRowView<T> extends StatelessWidget {
  const SelectorRowView({super.key, required this.item});

  final T item;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(color: theme.backgroundColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.lineWidth * 3,
          vertical: theme.lineWidth * 1,
        ),
        child: Center(
          child: Text(
            item.toString(),
            key: ValueKey(item),
          ),
        ),
      ),
    );
  }
}
