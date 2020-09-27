import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

void main() {
  group('beautify', () {
    test('returns the expected String', () {
      expect(beautify(null), equals('null'));
      expect(beautify({}), equals('{}'));
      expect(beautify({'id': 1, 'title': 'zxc'}), equals('''{
  "id": 1,
  "title": "zxc"
}'''));
    });
  });

  test('returns null on null input', () {
    expect(beautify(null), equals('null'));
  });
}
