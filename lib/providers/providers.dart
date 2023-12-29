import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_ui/components/components.dart';

final spinnerStateProvider = StateProvider<SpinnerState>(
  (ref) => SpinnerState.loading,
);

final lineThemeProvider = StateProvider<LineTheme>(
  (ref) => LineTheme.demoThemes()['default']!,
);
