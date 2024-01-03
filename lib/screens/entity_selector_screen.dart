import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components.dart';

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
            SingleSelector(
              items: [
                "first",
                "second",
                "third",
                "fourth",
                "fifth",
                "sixth",
              ],
              selectedItem: "fourth",
              onChange: (p0) {},
            ),
          ],
        ),
      ),
    );
  }
}
