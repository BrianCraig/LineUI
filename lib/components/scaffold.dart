import 'package:flutter/material.dart' hide Text, Scaffold;

import 'button.dart';
import 'line_theme.dart';
import 'text.dart';

class Scaffold extends StatelessWidget {
  const Scaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final navigator = Navigator.of(context);
    final canGoBack = navigator.canPop();
    return Material(
      child: Container(
        color: theme.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(theme.spacing),
              child: Row(
                children: [
                  if (canGoBack)
                    Padding(
                      padding: EdgeInsets.only(right: theme.spacing),
                      child: Button(
                        onPressed: () => navigator.maybePop(),
                        child: Icon(
                          Icons.arrow_back,
                          color: theme.textColor,
                          size: theme.spacing * 2,
                        ),
                      ),
                    ),
                  Text(title, fontSizeFactor: 2.0),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
