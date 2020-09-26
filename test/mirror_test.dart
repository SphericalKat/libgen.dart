import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/mirror.dart';
import 'package:test/test.dart';

import '__mocks__/results.dart';
import '__mocks__/schemas.dart';

void main() {
  group('LibgenMirror', () {
    final mockedClient = (response, [statusCode = 200]) => HttpClient(
          client: MockClient(
              (request) async => Response(json.encode(response), statusCode)),
        );

    final mockedLibgenMirror = ({bool withResults}) => LibgenMirror(
          client: mockedClient(withResults ? singleItemList : []),
        );

    group('fromSchema', () {
      test('creates a new LibgenMirror from LibgenMirrorSchema', () async {
        final mirror = LibgenMirror.fromSchema(schemaSample);

        expect(mirror is LibgenMirror, equals(true));
      });
    });

    group('getByIds', () {
      test('returns the expected list of objects', () async {
        final response = singleItemList;
        final mirror = LibgenMirror(
          client: mockedClient(response),
        );
        final result = await mirror.getByIds([1]);

        expect(result, equals(response));
      });

      test('returns an empty list', () async {
        final response = [];
        final mirror = mockedLibgenMirror(withResults: false);
        final result = await mirror.getByIds([999999]);

        expect(result, equals(response));
      });
    });

    group('ping', () {
      test('returns pong on success', () async {
        final mirror = mockedLibgenMirror(withResults: false);
        final result = await mirror.ping();

        expect(result, equals('pong'));
      });
    });

    group('canDownload', () {
      test('returns false', () async {
        final mirror = mockedLibgenMirror(withResults: false);

        expect(mirror.canDownload, equals(false));
      });
    });
  });
}
