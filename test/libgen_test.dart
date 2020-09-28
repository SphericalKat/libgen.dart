import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/mirror_schema_finder.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import '__mocks__/schema_mock.dart';

void main() {
  group('Libgen', () {
    final mockedClient = (response, [statusCode = 200]) => HttpClient(
          client: MockClient(
              (request) async => Response(json.encode(response), statusCode)),
        );

    final mockedLibgenMirror =
        ({bool withResults = false, bool canDownload = false}) => Libgen(
              client: mockedClient(withResults ? singleJsonList : []),
              options: MirrorOptions(canDownload: canDownload),
            );

    group('.fromSchema()', () {
      test('creates a new LibgenMirror from LibgenMirrorSchema', () async {
        final mirror = Libgen.fromSchema(workingSchemaSample);

        expect(mirror is Libgen, equals(true));
      });
    });

    group('.finder', () {
      test('returns a `MirrorSchemaFinder` instance', () async {
        expect(Libgen.finder is MirrorSchemaFinder, equals(true));
      });
    });

    group('.fastest', () {
      test('returns a `Libgen` instance', () async {
        expect(await Libgen.fastest() is Libgen, equals(true));
      });
    });

    group('.any', () {
      test('returns a `Libgen` instance', () async {
        expect(await Libgen.any() is Libgen, equals(true));
      });
    });

    group('.getById()', () {
      test('returns the expected Book', () async {
        final response = singleJsonList;
        final mirror = Libgen(
          client: mockedClient(response),
        );
        final result = await mirror.getById('1591104');

        expect(result, equals(darkMatterBook.object));
      });

      test('returns null on no results', () async {
        final mirror = mockedLibgenMirror(withResults: false);
        final result = await mirror.getById('999999');

        expect(result, equals(null));
      });
    });

    group('.ping()', () {
      test('returns pong on success', () async {
        final mirror = mockedLibgenMirror(withResults: false);
        final result = await mirror.ping();

        expect(result, equals('pong'));
      });
    });

    group('.canDownload', () {
      test('returns the expected value', () async {
        expect(mockedLibgenMirror().canDownload, equals(false));
        expect(
            mockedLibgenMirror(canDownload: false).canDownload, equals(false));
        expect(mockedLibgenMirror(canDownload: true).canDownload, equals(true));
      });
    });
  });
}
