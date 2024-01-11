import 'package:flutter/material.dart';
import 'package:line_ui/components/switch_container.dart';
import 'package:line_ui/helpers/extensions.dart';
import 'package:line_ui/helpers/math.dart' as math_ext;

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

abstract class LineTheme {
  Color get textColor;
  Color get backgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
  Color get accentColor;
  double get lineWidth;
  double get spacing;

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
      "blue": blueTheme,
      "blue (dark)": blueDarkTheme,
    };
  }

  static LineTheme copyTheme(
    LineTheme from, {
    Color? textColor,
    Color? backgroundColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    double? lineWidth,
    double? spacing,
  }) {
    return BasicLineTheme(
      textColor: textColor ?? from.textColor,
      backgroundColor: backgroundColor ?? from.backgroundColor,
      primaryColor: primaryColor ?? from.primaryColor,
      secondaryColor: secondaryColor ?? from.secondaryColor,
      accentColor: accentColor ?? from.accentColor,
      lineWidth: lineWidth ?? from.lineWidth,
      spacing: spacing ?? from.spacing,
    );
  }

  static lerp(LineTheme begin, LineTheme end, double t) {
    return BasicLineTheme(
      textColor: ColorExtensions.lerp(begin.textColor, end.textColor, t),
      backgroundColor:
          ColorExtensions.lerp(begin.backgroundColor, end.backgroundColor, t),
      primaryColor:
          ColorExtensions.lerp(begin.primaryColor, end.primaryColor, t),
      secondaryColor:
          ColorExtensions.lerp(begin.secondaryColor, end.secondaryColor, t),
      accentColor: ColorExtensions.lerp(begin.accentColor, end.accentColor, t),
      lineWidth: math_ext.lerp(begin.lineWidth, end.lineWidth, t),
      spacing: math_ext.lerp(begin.spacing, end.spacing, t),
    );
  }
}

const defaultTheme = BasicLineTheme(
  textColor: Color(0xFF0a0306),
  backgroundColor: Color(0xFFfbf3f7),
  primaryColor: Color(0xFFe16db0),
  secondaryColor: Color(0xFF99e0a7),
  accentColor: Color(0xFF67c6d1),
);

const darkTheme = BasicLineTheme(
  textColor: Color(0xFFe6f3e8),
  backgroundColor: Color(0xFF0a180c),
  primaryColor: Color(0xFF9bdda5),
  secondaryColor: Color(0xFF268635),
  accentColor: Color(0xFF3ad252),
);

const blueTheme = BasicLineTheme(
  textColor: Color(0xFF011713),
  backgroundColor: Color(0xFFfafffe),
  primaryColor: Color(0xFF14f2d0),
  secondaryColor: Color(0xFF76aef7),
  accentColor: Color(0xFF122ec4),
);

const blueDarkTheme = BasicLineTheme(
  textColor: Color(0xFFd6faed),
  backgroundColor: Color(0xFF020f0b),
  primaryColor: Color(0xFF87f2cb),
  secondaryColor: Color(0xFF113398),
  accentColor: Color(0xFF331ae6),
);

class BasicLineTheme implements LineTheme {
  const BasicLineTheme({
    required this.textColor,
    required this.backgroundColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    this.lineWidth = 2.0,
    this.spacing = 16.0,
  });

  @override
  final Color textColor,
      backgroundColor,
      primaryColor,
      secondaryColor,
      accentColor;
  @override
  final double lineWidth, spacing;

  bool get isLight => backgroundColor.luminance > textColor.luminance;

  @override
  String toString() =>
      'LineTheme: ${isLight ? '[Light]' : '[Dark]'}, primary: $primaryColor';
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

class LineThemeTween extends Tween<LineTheme> {
  LineThemeTween({super.begin, super.end});

  @override
  LineTheme lerp(double t) {
    assert(begin != null);
    assert(end != null);
    return LineTheme.lerp(begin!, end!, t);
  }
}

class AnimatedLineTheme extends ImplicitlyAnimatedWidget {
  /// Creates a widget that animates its `LineTheme` implicitly.
  const AnimatedLineTheme({
    super.key,
    required this.child,
    required this.theme,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  final Widget child;

  final LineTheme theme;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedLineTheme> createState() =>
      _AnimatedLineThemeState();
}

class _AnimatedLineThemeState
    extends ImplicitlyAnimatedWidgetState<AnimatedLineTheme> {
  Tween<LineTheme>? _theme;
  late Animation<LineTheme> _themeAnimation;

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _theme = visitor(_theme, widget.theme,
            (dynamic value) => LineThemeTween(begin: value as LineTheme))
        as Tween<LineTheme>;
  }

  @override
  void didUpdateTweens() {
    _themeAnimation = animation.drive(_theme!);
  }

  @override
  Widget build(BuildContext context) {
    return LineThemeProvider(
      theme: _themeAnimation.value,
      child: widget.child,
    );
  }
}
