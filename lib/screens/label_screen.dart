import 'package:flutter/widgets.dart' hide Text;

import '../components/components.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: 'Label Component',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Label.text('Simple text label'),
            Spacing.one,
            Label(
              child: Text('Simple label with text child widget'),
            ),
          ],
        ),
      ),
    );
  }
}
