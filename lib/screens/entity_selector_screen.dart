import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components.dart';

final singleSelectMandatoryStateProvider = StateProvider<String>(
  (ref) => "first",
);

final singleSelectOptionalStateProvider = StateProvider<String?>(
  (ref) => null,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 180,
              child: Column(
                children: [
                  Label.text('Single Selector Mandatory'),
                  Spacing.half,
                  SingleSelector(
                    items: items,
                    selectedItem: ref.watch(singleSelectMandatoryStateProvider),
                    onChange: (value) {
                      if (value != null) {
                        ref
                            .read(singleSelectMandatoryStateProvider.notifier)
                            .state = value;
                      }
                    },
                  ),
                ],
              ),
            ),
            Spacing.one,
            SizedBox(
              width: 180,
              child: Column(
                children: [
                  Label.text('Single Selector Optional'),
                  Spacing.half,
                  SingleSelector(
                    items: items,
                    selectedItem: ref.watch(singleSelectOptionalStateProvider),
                    onChange: (value) {
                      ref
                          .read(singleSelectOptionalStateProvider.notifier)
                          .state = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
