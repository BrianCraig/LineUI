import 'package:flutter/material.dart'
    show Scaffold, AppBar, Theme, ElevatedButton;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components.dart';

class ButtonsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: LineTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Button Component'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  child: Text('Oh, hi mark'),
                ),
                SizedBox(width: 16),
                Button(
                  style: ButtonStyle.secondary,
                  child: Text('Oh, hi mark'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  child: const Text('Go to the Button screen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
