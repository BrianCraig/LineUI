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

const _defaultTheme = LineTheme(
  textColor: Color(0xFF0a0306),
  backgroundColor: Color(0xFFfbf3f7),
  primaryColor: Color(0xFFe16db0),
  secondaryColor: Color(0xFF99e0a7),
  accentColor: Color(0xFF67c6d1),
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

  static LineTheme of(BuildContext context) {
    return _defaultTheme;
  }
}
