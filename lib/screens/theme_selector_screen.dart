import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_ui/providers/providers.dart';

import '../components/components.dart';
import '../helpers/extensions.dart';

extension ColorNames on Color {
  String toHex() {
    return '#${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  }

  String toRgb() {
    return 'rgb($red, $green, $blue)';
  }
}

class Copy extends StatelessWidget {
  final String text;
  final Widget child;

  const Copy({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _copyToClipboard(context);
        },
        behavior: HitTestBehavior.translucent,
        child: child,
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
  }
}

class ThemeDemostration extends StatelessWidget {
  const ThemeDemostration({super.key, required this.theme});

  final LineTheme theme;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: (theme) =>
          ColorExtensions.lerp(theme.backgroundColor, theme.textColor, 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeDemostrationRow(
                colorFromTheme: (theme) => theme.backgroundColor,
                title: 'Background',
              ),
              Spacing.half,
              ThemeDemostrationRow(
                colorFromTheme: (theme) => theme.textColor,
                title: 'Text',
              ),
            ],
          ),
          Spacing.one,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeDemostrationRow(
                colorFromTheme: (theme) => theme.primaryColor,
                title: 'Primary',
              ),
              Spacing.half,
              ThemeDemostrationRow(
                colorFromTheme: (theme) => theme.secondaryColor,
                title: 'Secondary',
              ),
              Spacing.half,
              ThemeDemostrationRow(
                colorFromTheme: (theme) => theme.accentColor,
                title: 'Accent',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ValueDescription<T> {
  ValueDescription(this.value, [this.description]);

  final T value;
  final String? description;

  @override
  String toString() => description ?? value.toString();

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) => switch (other) {
        (ValueDescription<T> otherVD) => value == otherVD.value,
        (ValueDescription otherVD) => value == otherVD.value,
        (Object other) => value == other
      };
}

class ThemeDemostrationRow extends StatelessWidget {
  const ThemeDemostrationRow({
    super.key,
    required this.title,
    required this.colorFromTheme,
  });

  final String title;
  final Color Function(LineTheme) colorFromTheme;

  @override
  Widget build(BuildContext context) {
    late final theme = LineTheme.of(context);
    final color = colorFromTheme(theme);
    final hexColor = color.toHex();
    final rgbColor = color.toRgb();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundedContainer(
          background: colorFromTheme,
          child: SizedBox(),
        ),
        Spacing.half,
        Text(title),
        Spacing.half,
        Copy(
          text: hexColor,
          child: Text(hexColor),
        ),
        Spacing.half,
        Copy(
          text: rgbColor,
          child: Text(rgbColor),
        ),
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
            SizedBox(
              width: 240,
              child: SingleSelector(
                items: LineTheme.demoThemes()
                    .entries
                    .map((entry) =>
                        ValueDescription(entry.value, 'Use ${entry.key} theme'))
                    .toList(),
                selectedItem: ValueDescription(ref.watch(lineThemeProvider)),
                onChange: (descriptor) {
                  if (descriptor == null) return;
                  ref.read(lineThemeProvider.notifier).state = descriptor.value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
