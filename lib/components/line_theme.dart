import 'package:flutter/material.dart';

/*
https://realtimecolors.com custom code

const theme = LineTheme(
  textColor: Color(${text.hexMtrl}),
  backgroundColor: Color(${bg.hexMtrl}),
  primaryColor: Color(${primary.hexMtrl}),
  secondaryColor: Color(${secondary.hexMtrl}),
  accentColor: Color(${accent.hexMtrl}),
);

 */

const defaultTheme = LineTheme(
  textColor: Color(0xFF0a0306),
  backgroundColor: Color(0xFFfbf3f7),
  primaryColor: Color(0xFFe16db0),
  secondaryColor: Color(0xFF99e0a7),
  accentColor: Color(0xFF67c6d1),
);

const darkTheme = LineTheme(
  textColor: Color(0xFFe6f3e8),
  backgroundColor: Color(0xFF0a180c),
  primaryColor: Color(0xFF9bdda5),
  secondaryColor: Color(0xFF268635),
  accentColor: Color(0xFF3ad252),
);

class LineTheme {
  const LineTheme({
    required this.textColor,
    required this.backgroundColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    this.lineWidth = 2.0,
  });

  final Color textColor,
      backgroundColor,
      primaryColor,
      secondaryColor,
      accentColor;

  final double lineWidth;

  static LineTheme? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LineThemeProvider>()
        ?.theme;
  }

  static LineTheme of(BuildContext context) {
    final LineTheme? result = maybeOf(context);
    assert(result != null, 'No LineThemeProvider found in context');
    return result!;
  }

  static Map<String, LineTheme> demoThemes() {
    return const {
      "default": defaultTheme,
      "dark": darkTheme,
    };
  }
}

class LineThemeProvider extends InheritedWidget {
  const LineThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  final LineTheme theme;

  @override
  bool updateShouldNotify(LineThemeProvider oldWidget) =>
      theme != oldWidget.theme;
}
