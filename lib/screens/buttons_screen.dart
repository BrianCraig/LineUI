import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components.dart';

class ButtonsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      title: 'Button Component',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  child: Text(
                    'Default button',
                  ),
                ),
                SizedBox(width: 16),
                Button.text(
                  style: ButtonStyle.secondary,
                  text: 'Secondary Button',
                ),
                SizedBox(width: 16),
                Button.icon(icon: Icons.add),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
