import 'package:flutter/widgets.dart' hide Icon, Text;

import 'package:line_ui/components/components.dart';
import 'package:line_ui/helpers/extensions.dart';

class Switch extends StatelessWidget {
  const Switch({super.key, required this.value, this.onChange});

  final bool value;
  final void Function(bool value)? onChange;

  @override
  Widget build(BuildContext context) {
    late final theme = LineTheme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (onChange != null) onChange!(!value);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: value
                ? theme.primaryColor
                : ColorExtensions.lerp(
                    theme.backgroundColor, theme.textColor, 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(theme.spacing * .5 + theme.lineWidth),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(theme.lineWidth),
            child: SizedBox(
              width: theme.spacing * 2.5,
              height: theme.spacing,
              child: Align(
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: SizedBox(
                  width: theme.spacing,
                  height: theme.spacing,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(theme.spacing * .5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
