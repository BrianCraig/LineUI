import 'package:flutter/material.dart'
    show Scaffold, AppBar, Theme, ElevatedButton;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/providers/providers.dart';

import '../components/components.dart';

class ThemeSelectorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = LineTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Select Demo Theme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...LineTheme.demoThemes().entries.map<Widget>(
                  (entry) => Button(
                    onPressed: () => {
                      ref.read(lineThemeProvider.notifier).state = entry.value
                    },
                    child: Text(
                      'Use ${entry.key} theme',
                      style: TextStyle(color: theme.textColor),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
