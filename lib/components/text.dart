import 'package:flutter/material.dart';
import 'package:line_ui/components/components.dart';

class Text extends StatelessWidget {
  const Text(this.text, {super.key, this.fontSizeFactor = 1.0, this.textAlign});

  final String text;
  final double fontSizeFactor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    defaultTextStyle.style.color;
    final TextScaler textScaler = MediaQuery.textScalerOf(context);

    return RichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      softWrap: defaultTextStyle.softWrap,
      overflow: defaultTextStyle.overflow,
      textScaler: textScaler,
      maxLines: defaultTextStyle.maxLines,
      textWidthBasis: defaultTextStyle.textWidthBasis,
      textHeightBehavior: defaultTextStyle.textHeightBehavior,
      text: TextSpan(
        style: defaultTextStyle.style.apply(
          color: theme.textColor,
          fontSizeFactor: fontSizeFactor,
        ),
        text: text,
      ),
    );
  }
}
