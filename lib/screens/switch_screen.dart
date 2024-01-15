import 'package:flutter/widgets.dart' hide Text, Icon;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components.dart';

final switchStateProvider = StateProvider<bool>(
  (ref) => false,
);

class SwitchScreen extends ConsumerWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'LinearInput Component',
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: ref.watch(switchStateProvider),
              onChange: (value) {
                ref.read(switchStateProvider.notifier).state = value;
              },
            ),
            Spacing.one,
            Button(
                child: Text(
              'Button reference',
            ))
          ],
        ),
      ),
    );
  }
}
