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
      expect(minNonNullIndex([]), isNull);
      expect(minNonNullIndex([null, null]), isNull);
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

    test('returns [null] on null input', () {
      expect(beautify(null), equals('null'));
    });
  });

  group('getResultsCount', () {
    test('returns the expected int', () {
      expect(getResultsCount(10), equals(25));
      expect(getResultsCount(5), equals(25));
      expect(getResultsCount(25), equals(25));
      expect(getResultsCount(30), equals(50));
      expect(getResultsCount(50), equals(50));
      expect(getResultsCount(70), equals(100));
      expect(getResultsCount(100), equals(100));
      expect(getResultsCount(120), equals(100));
    });
  });
}
