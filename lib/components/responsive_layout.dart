import 'package:flutter/widgets.dart';

class ResponsiveRule {
  const ResponsiveRule({
    this.from = double.negativeInfinity,
    this.to = double.infinity,
  });
  final double from, to;
}

class ResponsiveRules<T> {
  const ResponsiveRules({
    required this.rules,
    required this.defaultLayout,
  });

  final List<(ResponsiveRule, T)> rules;
  final T defaultLayout;
}

class ResponsiveLayout {
  static T of<T>(BuildContext context, ResponsiveRules<T> rules) {
    return rules.defaultLayout;
  }
}

class ResponsiveLayoutProvider extends StatelessWidget {
  const ResponsiveLayoutProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
