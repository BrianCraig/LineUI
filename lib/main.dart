import 'package:flutter/material.dart' hide Text, Scaffold;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_ui/screens/entity_selector_screen.dart';
import 'package:line_ui/screens/linear_input_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:line_ui/apps/town-telly/app.dart' show TownTellyApp;
import 'package:line_ui/components/components.dart';
import 'package:line_ui/helpers/extensions.dart';
import 'package:line_ui/screens/buttons_screen.dart';
import 'package:line_ui/screens/theme_selector_screen.dart';

import 'providers/providers.dart';
import 'screens/label_screen.dart';
import 'screens/switch_screen.dart';

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

final List<_Page> _pages = [
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
    component: const EntitySelectorScreen(),
    path: 'entity-selector',
    buttonText: 'SingleSelector / MultiSelector Component',
  ),
  _Page(
    component: const LinearInputScreen(),
    path: 'linear-input',
    buttonText: 'LinearInput Component',
  ),
  _Page(
    component: const LabelScreen(),
    path: 'label',
    buttonText: 'Label Component',
  ),
  _Page(
    component: const SwitchScreen(),
    path: 'switch',
    buttonText: 'Switch Component',
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
      routes: _pages
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
          children: _pages
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
      child: ResponsiveBreakpoints(
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: _router,
        ),
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
                Spacing.one,
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
            Spacing.one,
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
