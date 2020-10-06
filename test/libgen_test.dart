import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import '__mocks__/schema_mock.dart';
import 'utils.dart';

void main() {
  group('Libgen', () {
    group('.fromSchema()', () {
      test('creates a new [Libgen] from [MirrorSchema]', () async {
        final mirror = Libgen.fromSchema(workingSchemaSample);

        expect(mirror is Libgen, isTrue);
      });
    });

    group('.finder', () {
      test('returns a [MirrorFinder] instance', () async {
        expect(Libgen.finder is MirrorFinder, isTrue);
      });
    });

    group('.fastest', () {
      test('returns a [Libgen] instance', () async {
        expect(await Libgen.fastest() is Libgen, isTrue);
      });
    });

    group('.any', () {
      test('returns a [Libgen] instance', () async {
        expect(await Libgen.any() is Libgen, isTrue);
      });
    });

    group('.getById()', () {
      test('returns the expected [Book]', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.getById(1591104);

        expect(result, darkMatterBook.object);
      });

      test('returns null on no results', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.getById(-1);

        expect(result, isNull);
      });
    });

    group('.getByIds()', () {
      test('returns the expected [List] of [Book]', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final expected = {
          1: firstBook.object,
          1591104: darkMatterBook.object,
        };
        final result = await mirror.getByIds(List<int>.from(expected.keys));

        expect(result, expected.values);
      });

      test('returns empty array on no results', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.getByIds([-1]);

        expect(result, []);
      });
    });

    group('.ping()', () {
      test('returns pong on success', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.ping();

        expect(result, 'pong');
      });
    });

    group('.canDownload', () {
      test('returns false when [options] are missing', () async {
        final mirror = Libgen(client: defaultMockedClient());

        expect(mirror.canDownload, isFalse);
      });

      test('returns the expected value', () async {
        expect(
          Libgen(
            client: defaultMockedClient(),
            options: MirrorOptions(canDownload: false),
          ).canDownload,
          isFalse,
        );
        expect(
          Libgen(
            client: defaultMockedClient(),
            options: MirrorOptions(canDownload: true),
          ).canDownload,
          isTrue,
        );
      });
    });
  });
}
