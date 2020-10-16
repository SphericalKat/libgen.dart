import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/page_parser.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import '__mocks__/libgen_api_mock.dart';
import '__mocks__/pages_mock.dart';
import '__mocks__/schema_mock.dart';
import 'constants.dart';

void main() {
  group('Libgen', () {
    test('default mirror works', () async {
      final mirror = Libgen();

      expect(await mirror.ping(), 'pong');
    }, tags: HTTP);

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
      }, tags: HTTP);
    });

    group('.any', () {
      test('returns a [Libgen] instance', () async {
        expect(await Libgen.any() is Libgen, isTrue);
      }, tags: HTTP);
    });

    group('.getById()', () {
      test('returns the expected [Book]', () async {
        final mirror = Libgen(api: mockedLibgenApi());
        final result = await mirror.getById(1591104);

        expect(result, darkMatterBook.object);
      });

      test('returns Null on no results', () async {
        final mirror = Libgen(api: mockedLibgenApi());
        final result = await mirror.getById(-1);

        expect(result, isNull);
      });

      test('returns Null when Null is the [id]', () async {
        final mirror = Libgen(api: mockedLibgenApi());
        final result = await mirror.getById(null);

        expect(result, isNull);
      });
    });

    group('.getByIds()', () {
      test('returns the expected [List] of [Book]', () async {
        final mirror = Libgen(api: mockedLibgenApi());
        final expected = {
          1: firstBook.object,
          1591104: darkMatterBook.object,
        };
        final result = await mirror.getByIds(List<int>.from(expected.keys));

        expect(result, expected.values);
      });

      test('returns empty list on no results', () async {
        final mirror = Libgen(api: mockedLibgenApi());
        final result = await mirror.getByIds([-1]);

        expect(result, []);
      });
    });

    group('.ping()', () {
      test('returns pong on success', () async {
        final mirror = Libgen(api: mockedLibgenApi());
        final result = await mirror.ping();

        expect(result, 'pong');
      });
    });

    group('.getLatestId()', () {
      test('returns the expected first id from the list', () async {
        final api = MockLibgenApi();
        when(api.search(any))
            .thenAnswer((_) async => parsedPageWithIds([1, 2]));

        final mirror = Libgen(api: api);
        final result = await mirror.getLatestId();

        expect(result, 1);
      });
    });

    group('.getLatest()', () {
      test('returns the expected first id from the list', () async {
        final api = mockedLibgenApi();
        when(api.search(any)).thenAnswer((_) async => parsedPageWithIds([1]));

        final mirror = Libgen(api: api);
        final result = await mirror.getLatest();
        verify(api.search({'mode': 'last'}));

        expect(result, firstBook.object);
      });
    });

    group('.search()', () {
      test('returns the expected List', () async {
        final query = 'something';
        final expected = [darkMatterBook.object];
        final ids = expected.map((e) => e.id).toList();
        final api = mockedLibgenApi();
        when(api.search(any)).thenAnswer((_) async => parsedPageWithIds(ids));

        final mirror = Libgen(api: api);
        final result = await mirror.search(query: query);
        verify(api.search({
          'req': query,
          'res': '25',
          'page': '1',
          'column': 'def',
          'view': 'simple',
        }));

        expect(result, expected);
      });

      test('returns an empty list when no items found', () async {
        final api = mockedLibgenApi();
        when(api.search(any)).thenAnswer((_) async => PageParser('invalid'));

        final mirror = Libgen(api: api);
        final result = await mirror.search(query: 'something');

        expect(result, []);
      });
    });

    group('.canDownload', () {
      test('returns false when [options] are missing', () async {
        final mirror = Libgen(api: mockedLibgenApi());

        expect(mirror.canDownload, isFalse);
      });

      test('returns the expected value', () async {
        expect(
          Libgen(
            api: mockedLibgenApi(),
            options: MirrorOptions(canDownload: false),
          ).canDownload,
          isFalse,
        );
        expect(
          Libgen(
            api: mockedLibgenApi(),
            options: MirrorOptions(canDownload: true),
          ).canDownload,
          isTrue,
        );
      });
    });
  });
}
