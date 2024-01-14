import 'package:flutter/widgets.dart';

import 'line_theme.dart';
import 'container.dart';

enum SwitchThemeStrategy {
  textIsBackground,
  primaryBackgroundTextSwitch,
  secondaryBackgroundTextSwitch,
  accentBackgroundTextSwitch,
}

extension ColorContrast on Color {
  double get brightness => 0.299 * red + 0.587 * green + 0.114 * blue;

  double calculateContrast(Color other) {
    final l1 = computeLuminance();
    final l2 = other.computeLuminance();
    return (l1 >= l2) ? (l1 + .05) / (l2 + .05) : (l2 + .05) / (l1 + .05);
  }

  bool isContrastRatioAA(Color other) {
    return calculateContrast(other) >= 4.5;
  }

  bool isContrastRatioAAA(Color other) {
    return calculateContrast(other) >= 7.0;
  }
}

Color bestContrastPicker(Color base, Color a, Color b) =>
    base.calculateContrast(a) > base.calculateContrast(b) ? a : b;

Color worstContrastPicker(Color base, Color a, Color b) =>
    base.calculateContrast(a) <= base.calculateContrast(b) ? a : b;

class SwitchTheme extends StatelessWidget {
  const SwitchTheme({
    super.key,
    required this.child,
    this.strategy = SwitchThemeStrategy.textIsBackground,
  });

  final Widget child;
  final SwitchThemeStrategy strategy;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final newTheme = switch (strategy) {
      SwitchThemeStrategy.textIsBackground => BasicLineTheme(
          textColor: theme.backgroundColor,
          backgroundColor: theme.textColor,
          primaryColor: theme.primaryColor,
          secondaryColor: theme.secondaryColor,
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        ),
      SwitchThemeStrategy.primaryBackgroundTextSwitch => BasicLineTheme(
          textColor: bestContrastPicker(
            theme.primaryColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          backgroundColor: theme.primaryColor,
          primaryColor: worstContrastPicker(
            theme.primaryColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          secondaryColor: theme.secondaryColor,
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        ),
      SwitchThemeStrategy.secondaryBackgroundTextSwitch => BasicLineTheme(
          textColor: bestContrastPicker(
            theme.secondaryColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          backgroundColor: theme.secondaryColor,
          primaryColor: theme.primaryColor,
          secondaryColor: worstContrastPicker(
            theme.secondaryColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        ),
      SwitchThemeStrategy.accentBackgroundTextSwitch => BasicLineTheme(
          textColor: bestContrastPicker(
            theme.accentColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          backgroundColor: theme.accentColor,
          primaryColor: theme.primaryColor,
          secondaryColor: theme.secondaryColor,
          accentColor: worstContrastPicker(
            theme.accentColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        )
    };

    return LineThemeProvider(
      theme: newTheme,
      child: child,
    );
  }
}

class SwitchContainer extends StatelessWidget {
  const SwitchContainer({
    super.key,
    required this.child,
    this.strategy = SwitchThemeStrategy.textIsBackground,
  });

  final Widget child;
  final SwitchThemeStrategy strategy;

  @override
  Widget build(BuildContext context) {
    return SwitchTheme(
        strategy: strategy, child: RoundedContainer(child: child));
  }
}
