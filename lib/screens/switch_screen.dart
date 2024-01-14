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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 320,
              child: Switch(
                value: ref.watch(switchStateProvider),
                onChange: (value) {
                  ref.read(switchStateProvider.notifier).state = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
