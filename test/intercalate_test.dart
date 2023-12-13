import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/helpers/extensions.dart';

void main() {
  test('InterpolateExtension intercalate test', () {
    final List<int> myList = [1, 2, 3, 4];
    final List<int> expectedResult = [1, -1, 2, -1, 3, -1, 4];

    final result = myList.intercalate(-1).toList();

    expect(result, equals(expectedResult));
  });

  test('InterpolateExtension intercalate with empty list', () {
    final List<int> emptyList = [];
    final List<int> expectedResult = [];

    final result = emptyList.intercalate(-1).toList();

    expect(result, equals(expectedResult));
  });

  // Add more test cases if needed
}
