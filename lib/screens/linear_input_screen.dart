import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_ui/components/linear_input.dart';

import '../components/components.dart';

final basicLinearInputStateProvider = StateProvider<double>(
  (ref) => 0.2,
);

class LinearInputScreen extends ConsumerWidget {
  const LinearInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'LinearInput Component',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
                showStart: false,
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
                showEnd: false,
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 320,
              child: LinearInput(
                value: ref.watch(basicLinearInputStateProvider),
                onChange: (value) {
                  ref.read(basicLinearInputStateProvider.notifier).state =
                      value;
                },
                showStart: false,
                showEnd: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
