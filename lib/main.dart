import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/components/components.dart';

import 'helpers/screen_information.dart';
import 'providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> buttons =
        ref.watch(spinnerStateProvider) == SpinnerState.loading
            ? [
                TextButton(
                    onPressed: () => {
                          ref.read(spinnerStateProvider.notifier).state =
                              SpinnerState.success
                        },
                    child: Text('Success')),
                SizedBox(width: 16),
                TextButton(
                    onPressed: () => {
                          ref.read(spinnerStateProvider.notifier).state =
                              SpinnerState.error
                        },
                    child: Text('Error')),
              ]
            : [
                TextButton(
                    onPressed: () => {
                          ref.read(spinnerStateProvider.notifier).state =
                              SpinnerState.loading
                        },
                    child: Text('Restart'))
              ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Line UI Component System'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spinner(
              state: ref.read(spinnerStateProvider),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttons,
            ),
            ScreenInformation(),
          ],
        ),
      ),
    );
  }
}
