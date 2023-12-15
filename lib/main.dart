import 'package:flutter/material.dart' hide Text, Scaffold;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/apps/town-telly/app.dart' show TownTellyApp;
import 'package:test_app/components/components.dart';
import 'package:test_app/components/line_theme.dart';
import 'package:test_app/helpers/extensions.dart';
import 'package:test_app/screens/buttons_screen.dart';
import 'package:test_app/screens/theme_selector_screen.dart';

import 'providers/providers.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class _Page {
  _Page(
      {required this.component, required this.path, required this.buttonText});

  final Widget component;
  final String path, buttonText;
}

final List<_Page> pages = [
  _Page(
    component: SpinnerScreen(),
    path: 'spinner',
    buttonText: 'Spinner Component',
  ),
  _Page(
    component: ButtonsScreen(),
    path: 'button',
    buttonText: 'Button Component',
  ),
  _Page(
    component: ThemeSelectorScreen(),
    path: 'theme-selector',
    buttonText: 'Select Theme',
  ),
  _Page(
    component: const TownTellyApp(),
    path: 'app/town-telly',
    buttonText: 'TownTelly App example',
  ),
];

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: pages
          .map<RouteBase>(
            (page) => GoRoute(
              path: page.path,
              builder: (BuildContext context, GoRouterState state) {
                return page.component;
              },
            ),
          )
          .toList(),
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: 'Home Screen',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: pages
              .map<Widget>(
                (page) => Button(
                  child: Text(page.buttonText),
                  onPressed: () => context.go("/${page.path}"),
                ),
              )
              .intercalate(Spacing.half)
              .toList(),
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
                Button(
                    onPressed: () => {
                          ref.read(spinnerStateProvider.notifier).state =
                              SpinnerState.success
                        },
                    child: Text('Success')),
                SizedBox(width: 16),
                Button(
                    onPressed: () => {
                          ref.read(spinnerStateProvider.notifier).state =
                              SpinnerState.error
                        },
                    child: Text('Error')),
              ]
            : [
                Button(
                    onPressed: () => {
                          ref.read(spinnerStateProvider.notifier).state =
                              SpinnerState.loading
                        },
                    child: Text('Restart'))
              ];

    return Scaffold(
      title: 'Spinner Component',
      child: Center(
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
