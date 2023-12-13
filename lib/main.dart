import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/components/components.dart';
import 'package:test_app/components/line_theme.dart';
import 'package:test_app/screens/buttons_screen.dart';
import 'package:test_app/screens/theme_selector_screen.dart';

import 'helpers/screen_information.dart';
import 'providers/providers.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'spinner',
          builder: (BuildContext context, GoRouterState state) {
            return SpinnerScreen();
          },
        ),
        GoRoute(
          path: 'button',
          builder: (BuildContext context, GoRouterState state) {
            return ButtonsScreen();
          },
        ),
        GoRoute(
          path: 'theme-selector',
          builder: (BuildContext context, GoRouterState state) {
            return ThemeSelectorScreen();
          },
        ),
      ],
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/spinner'),
              child: const Text('Go to the Spinner screen'),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => context.go('/button'),
              child: const Text('Go to the Button screen'),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => context.go('/theme-selector'),
              child: const Text('Select Theme'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LineThemeProvider(
      theme: ref.watch(lineThemeProvider),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

class SpinnerScreen extends ConsumerWidget {
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
          ],
        ),
      ),
    );
  }
}
