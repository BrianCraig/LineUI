import 'package:flutter/widgets.dart';

import 'line_theme.dart';

Color backgroundColor(LineTheme theme) => theme.backgroundColor;

EdgeInsetsGeometry paddingGeometry(LineTheme theme) =>
    EdgeInsets.all(theme.spacing);

BorderRadiusGeometry radiusSize(LineTheme theme) => BorderRadius.all(
      Radius.circular(
        theme.lineWidth * 4,
      ),
    );

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.child,
    this.background = backgroundColor,
    this.padding = paddingGeometry,
    this.radius = radiusSize,
  });

  final Widget child;
  final EdgeInsetsGeometry Function(LineTheme) padding;
  final Color Function(LineTheme) background;
  final BorderRadiusGeometry Function(LineTheme theme) radius;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background(theme),
        borderRadius: radius(theme),
      ),
      child: Padding(
        padding: padding(theme),
        child: child,
      ),
    );
  }
}
