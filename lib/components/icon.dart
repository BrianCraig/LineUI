import 'package:flutter/widgets.dart';

import 'line_theme.dart';

class Icon extends StatelessWidget {
  const Icon(this.icon, {super.key, this.size = 24, this.color});

  final IconData icon;

  final Color? color;

  final double size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.visible,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          color: color ?? LineTheme.of(context).textColor,
          fontSize: size,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontFamilyFallback: icon.fontFamilyFallback,
        ),
      ),
    );
  }
}
