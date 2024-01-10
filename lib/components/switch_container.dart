import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:line_ui/components/line_theme.dart';

enum SwitchContainerStrategy {
  textIsBackground,
  primaryBackgroundTextSwitch,
  secondaryBackgroundTextSwitch,
  accentBackgroundTextSwitch,
}

extension ColorContrast on Color {
  double get brightness => 0.299 * red + 0.587 * green + 0.114 * blue;

  double get luminance {
    double convert(int color) {
      double v = color / 255;
      if (v <= 0.03928) {
        return v / 12.92;
      } else {
        return pow(((v + 0.055) / 1.055), 2.4) as double;
      }
    }

    return (0.2126 * convert(red)) +
        (0.7152 * convert(green)) +
        (0.0722 * convert(blue));
  }

  double calculateContrast(Color other) {
    final l1 = luminance;
    final l2 = other.luminance;
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
      SwitchContainerStrategy.textIsBackground => BasicLineTheme(
          textColor: theme.backgroundColor,
          backgroundColor: theme.textColor,
          primaryColor: theme.primaryColor,
          secondaryColor: theme.secondaryColor,
          accentColor: theme.accentColor,
          lineWidth: theme.lineWidth,
          spacing: theme.spacing,
        ),
      SwitchContainerStrategy.primaryBackgroundTextSwitch => BasicLineTheme(
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
      SwitchContainerStrategy.secondaryBackgroundTextSwitch => BasicLineTheme(
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
      SwitchContainerStrategy.accentBackgroundTextSwitch => BasicLineTheme(
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
