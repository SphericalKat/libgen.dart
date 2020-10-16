import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/mirrors.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import 'constants.dart';

void main() {
  group('mirrors', () {
    for (final schema in mirrorSchemas) {
      _testSchema(schema);
    }
  }, tags: HTTP);
}

void _testSchema(MirrorSchema schema) {
  group(schema.baseUri, () {
    final mirror = Libgen.fromSchema(schema);

    test('returns "pong" on [ping]', () async {
      expect(await mirror.ping(), 'pong');
    });

    test('returns the expected [Book]', () async {
      expect(await mirror.getById(darkMatterBook.id), darkMatterBook.object);
    });
  });
}
