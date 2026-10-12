import 'package:flutter_test/flutter_test.dart';
import 'package:myplaces/core/extensions/StringExtensions.dart';

void main() {
  group('StringExtensions', () {
    test('converts strings to title case', () {
      expect('hello ciao world'.toTitleCase(), 'Hello Ciao World');
      expect('HELLO WORLD'.toTitleCase(), 'Hello World');
      expect('  hello   world  '.toTitleCase(), 'Hello World');
      expect(''.toTitleCase(), '');
    });
  });
}
