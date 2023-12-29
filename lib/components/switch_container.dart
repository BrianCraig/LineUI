import 'package:flutter/material.dart';
import 'package:line_ui/components/line_theme.dart';

enum SwitchContainerStrategy {
  textIsBackground,
  primaryBackgroundTextSwitch,
  secondaryBackgroundTextSwitch,
}

class SwitchContainer extends StatelessWidget {
  const SwitchContainer({
    super.key,
    required this.child,
    this.strategy = SwitchContainerStrategy.textIsBackground,
  });

  final Widget child;
  final SwitchContainerStrategy strategy;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final newTheme = switch (strategy) {
      SwitchContainerStrategy.textIsBackground => LineTheme(
          textColor: theme.backgroundColor,
          backgroundColor: theme.textColor,
          primaryColor: theme.primaryColor,
          secondaryColor: theme.secondaryColor,
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        ),
      SwitchContainerStrategy.primaryBackgroundTextSwitch => LineTheme(
          textColor: theme.backgroundColor,
          backgroundColor: theme.primaryColor,
          primaryColor: theme.backgroundColor,
          secondaryColor: theme.secondaryColor,
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        ),
      SwitchContainerStrategy.secondaryBackgroundTextSwitch => LineTheme(
          textColor: theme.backgroundColor,
          backgroundColor: theme.secondaryColor,
          primaryColor: theme.primaryColor,
          secondaryColor: theme.backgroundColor,
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        )
    };

    return LineThemeProvider(
      theme: newTheme,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: newTheme.backgroundColor,
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
