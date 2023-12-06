import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/components/components.dart';

final spinnerStateProvider = StateProvider<SpinnerState>(
  (ref) => SpinnerState.loading,
);
