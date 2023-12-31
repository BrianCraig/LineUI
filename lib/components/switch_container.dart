import 'package:flutter/material.dart';
import 'package:line_ui/components/line_theme.dart';

enum SwitchContainerStrategy {
  textIsBackground,
  primaryBackgroundTextSwitch,
  secondaryBackgroundTextSwitch,
}

extension ColorContrast on Color {
  double calculateContrast(Color other) {
    final brightness1 = (0.299 * red + 0.587 * green + 0.114 * blue);
    final brightness2 =
        (0.299 * other.red + 0.587 * other.green + 0.114 * other.blue);

    final contrastRatio = (brightness1 + 0.05) / (brightness2 + 0.05);
    return contrastRatio;
  }

  bool isContrastRatioAA(Color other, double contrastRatio) {
    return calculateContrast(other) >= 4.5;
  }

  bool isContrastRatioAAA(Color other, double contrastRatio) {
    return calculateContrast(other) >= 7.0;
  }
}

Color bestContrastPicker(Color base, Color a, Color b) =>
    base.calculateContrast(a) > base.calculateContrast(b) ? a : b;

Color worstContrastPicker(Color base, Color a, Color b) =>
    base.calculateContrast(a) <= base.calculateContrast(b) ? a : b;

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
      SwitchContainerStrategy.secondaryBackgroundTextSwitch => LineTheme(
          textColor: bestContrastPicker(
            theme.secondaryColor,
            theme.textColor,
            theme.backgroundColor,
          ),
          backgroundColor: theme.secondaryColor,
          primaryColor: theme.primaryColor,
          secondaryColor: bestContrastPicker(
            theme.secondaryColor,
            theme.textColor,
            theme.backgroundColor,
          ),
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
