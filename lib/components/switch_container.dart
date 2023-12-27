import 'package:flutter/material.dart';
import 'package:test_app/components/line_theme.dart';

class SwitchContainer extends StatelessWidget {
  const SwitchContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);

    return LineThemeProvider(
      theme: LineTheme(
        textColor: theme.textColor,
        backgroundColor: theme.primaryColor,
        primaryColor: theme.backgroundColor,
        secondaryColor: theme.accentColor,
        accentColor: theme.secondaryColor,
        lineWidth: theme.lineWidth,
        spacing: theme.spacing,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(theme.lineWidth * 4),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacing),
          child: child,
        ),
      ),
    );
  }
}
