import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_ui/helpers/extensions.dart';
import 'package:line_ui/providers/providers.dart';

import '../components/components.dart';

class ThemeDemostration extends StatelessWidget {
  const ThemeDemostration({super.key, required this.theme});

  final LineTheme theme;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: (theme) =>
          Color.lerp(theme.backgroundColor, theme.textColor, 0.05)!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ThemeDemostrationRow(
            color: (theme) => theme.backgroundColor,
            title: 'Background',
          ),
          Spacing.half,
          ThemeDemostrationRow(
            color: (theme) => theme.textColor,
            title: 'Text',
          ),
          Spacing.half,
          ThemeDemostrationRow(
            color: (theme) => theme.secondaryColor,
            title: 'Secondary',
          ),
          Spacing.half,
          ThemeDemostrationRow(
            color: (theme) => theme.accentColor,
            title: 'Accent',
          ),
          Spacing.half,
          ThemeDemostrationRow(
            color: (theme) => theme.primaryColor,
            title: 'Primary',
          ),
        ],
      ),
    );
  }
}

class ThemeDemostrationRow extends StatelessWidget {
  const ThemeDemostrationRow({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color Function(LineTheme) color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundedContainer(
          background: color,
          child: SizedBox(
            height: 0,
            width: 0,
          ),
        ),
        Spacing.one,
        Text(title),
      ],
    );
  }
}

class ThemeSelectorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'Select Demo Theme',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeDemostration(
              theme: ref.read(lineThemeProvider),
            ),
            Spacing.one,
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
