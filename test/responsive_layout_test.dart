import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:line_ui/components/responsive_layout.dart';

enum Layouts { phone, tablet, desktop }

const rule = ResponsiveRules(
  rules: [
    (ResponsiveRule(to: 600), Layouts.phone),
    (ResponsiveRule(from: 600, to: 1200), Layouts.tablet),
  ],
  defaultLayout: Layouts.desktop,
);

class TestBuildCounter extends StatelessWidget {
  const TestBuildCounter({super.key, required this.child});

  final Widget child;

  static int buildCount = 0;

  @override
  Widget build(BuildContext context) {
    buildCount += 1;
    return child;
  }
}

class LayoutExplainer extends StatelessWidget {
  const LayoutExplainer({super.key});

  @override
  Widget build(BuildContext context) {
    String text = switch (ResponsiveLayout.of(context, rule)) {
      Layouts.phone => "Phone",
      Layouts.tablet => "Tablet",
      Layouts.desktop => "Desktop"
    };
    return TestBuildCounter(
      key: Key(text),
      child: const SizedBox(),
    );
  }
}

void main() {
  testWidgets('Responsive Layout correct rebuild', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));

    await tester.pumpWidget(
      const ResponsiveLayoutProvider(
        child: LayoutExplainer(),
      ),
    );

    expect(TestBuildCounter.buildCount, 1);
    expect(find.byKey(const Key('Tablet')), findsOneWidget);

    await tester.pump();

    expect(TestBuildCounter.buildCount, 1);
    expect(find.byKey(const Key('Tablet')), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(600, 1200));

    expect(TestBuildCounter.buildCount, 1);
    expect(find.byKey(const Key('Tablet')), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(2000, 1200));

    expect(TestBuildCounter.buildCount, 2);
    expect(find.byKey(const Key('Desktop')), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(200, 1200));

    expect(TestBuildCounter.buildCount, 3);
    expect(find.byKey(const Key('Phone')), findsOneWidget);
  });
}
