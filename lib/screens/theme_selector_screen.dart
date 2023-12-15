import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/helpers/extensions.dart';
import 'package:test_app/providers/providers.dart';

import '../components/components.dart';

class ThemeSelectorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'Select Demo Theme',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...LineTheme.demoThemes()
                .entries
                .map<Widget>(
                  (entry) => Button(
                    onPressed: () => {
                      ref.read(lineThemeProvider.notifier).state = entry.value
                    },
                    child: Text(
                      'Use ${entry.key} theme',
                    ),
                  ),
                )
                .intercalate(
                  Spacing.half,
                ),
          ],
        ),
      ),
    );
  }
}
