import 'package:flutter/widgets.dart' hide Text;

import '../../components/components.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return Scaffold(
      title: 'Quiz App',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing),
        alignment: Alignment.topCenter,
        constraints: BoxConstraints.loose(const Size(960, double.infinity)),
        child: Column(
          children: [
            Text(
              'Try your best on this Quiz game',
              textAlign: TextAlign.center,
              fontSizeFactor: 2,
            ),
            Flexible(child: SizedBox.expand(), flex: 1),
            Button.text(
              text: 'New Game',
              onPressed: () => {},
            ),
            Spacing.half,
            Button.text(
              text: 'Highscores',
              onPressed: () => {},
            ),
            Flexible(
              child: SizedBox.expand(),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
