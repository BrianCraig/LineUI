import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components.dart';

final singleSelectStateProvider = StateProvider<String>(
  (ref) => "fourth",
);

const items = [
  "first",
  "second",
  "third",
  "fourth",
  "fifth",
  "sixth",
];

class EntitySelectorScreen extends ConsumerWidget {
  const EntitySelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'SingleSelector / MultiSelector Component',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 180,
              child: SingleSelector(
                items: items,
                selectedItem: ref.watch(singleSelectStateProvider),
                onChange: (value) {
                  ref.read(singleSelectStateProvider.notifier).state = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
