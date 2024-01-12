import 'package:flutter/widgets.dart' hide Text;
import 'package:line_ui/components/components.dart';

import 'switch_container.dart';
import 'text.dart';

EdgeInsetsGeometry paddingGeometry(LineTheme theme) => EdgeInsets.symmetric(
      vertical: theme.spacing * 0,
      horizontal: theme.spacing * .25,
    );

BorderRadiusGeometry radiusSize(LineTheme theme) => BorderRadius.all(
      Radius.circular(
        theme.lineWidth * 2,
      ),
    );

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.child,
    this.strategy = SwitchThemeStrategy.textIsBackground,
  });

  final Widget child;
  final SwitchThemeStrategy strategy;

  @override
  Widget build(BuildContext context) {
    return SwitchTheme(
      strategy: strategy,
      child: RoundedContainer(
        padding: paddingGeometry,
        radius: radiusSize,
        child: child,
      ),
    );
  }

  static Label text(
    String text, {
    strategy = SwitchThemeStrategy.textIsBackground,
  }) =>
      Label(
        strategy: strategy,
        child: Text(text),
      );
}
