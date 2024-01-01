import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:line_ui/components/switch_container.dart';

void main() {
  test('Color Brightness Test', () {
    // Test color
    Color color = Color.fromRGBO(128, 128, 128, 1); // gray

    // Test brightness calculation
    expect(color.brightness,
        closeTo(128.0, 0.1)); // Expected brightness value for gray
  });

  test('Color Contrast Test', () {
    // Test colors
    Color color1 = Color.fromRGBO(255, 255, 255, 1); // white
    Color color2 = Color.fromRGBO(0, 0, 0, 1); // black

    expect(color1.calculateContrast(color2), 21);

    // Test for AA and AAA contrast ratios
    expect(color1.isContrastRatioAA(color2), isTrue);
    expect(color1.isContrastRatioAAA(color2), isTrue);
  });
}
