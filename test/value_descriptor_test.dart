import 'package:flutter_test/flutter_test.dart';
import 'package:line_ui/screens/theme_selector_screen.dart';

void main() {
  test('Basic matching', () {
    expect(3, equals(ValueDescription(3)));
    expect(3, equals(ValueDescription(3, "Additional description")));
    expect(3, isNot(equals(ValueDescription(4))));
    expect(3, isNot(equals(ValueDescription("Hey"))));

    expect(3.toString(), equals(ValueDescription(3)));
    expect(
        3.toString(), isNot(equals(ValueDescription(3, "Override toString"))));
  });
}
