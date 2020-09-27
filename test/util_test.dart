import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

void main() {
  group('minNonNullIndex', () {
    test('returns the expected index', () async {
      expect(minNonNullIndex([1, 2, 3]), equals(0));
      expect(minNonNullIndex([2, 1, 3]), equals(1));
      expect(minNonNullIndex([2, null, 3]), equals(0));
    });

    test('returns null', () async {
      expect(minNonNullIndex([]), equals(null));
      expect(minNonNullIndex([null, null]), equals(null));
    });
  });

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
