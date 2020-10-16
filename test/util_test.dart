import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

void main() {
  group('minNonNullIndex', () {
    test('returns the expected index', () async {
      expect(minNonNullIndex([1, 2, 3]), 0);
      expect(minNonNullIndex([2, 1, 3]), 1);
      expect(minNonNullIndex([2, null, 3]), 0);
    });

    test('returns Null', () async {
      expect(minNonNullIndex([]), isNull);
      expect(minNonNullIndex([null, null]), isNull);
    });
  });

  group('beautify', () {
    test('returns the expected String', () {
      expect(beautify(null), 'null');
      expect(beautify({}), '{}');
      expect(beautify({'id': 1, 'title': 'zxc'}), '''{
  "id": 1,
  "title": "zxc"
}''');
    });

    test('returns Null on Null input', () {
      expect(beautify(null), 'null');
    });
  });
}
