import 'package:libgen/src/exceptions.dart';
import 'package:libgen/src/http_client.dart';
import 'package:test/test.dart';

import '__mocks__/client_mock.dart';

void main() {
  group('HttpClient', () {
    // TODO add #http tag
    test('provides a default [client]', () async {
      final baseUri = Uri.https('example.com', '');
      final client = HttpClient(baseUri: baseUri);
      final response = await client.get('');

      expect(response, isA<String>());
    });

    test('accepts a [client]', () async {
      final expected = 'something';
      final client = HttpClient(client: mockedClientWithResponse(expected));
      final response = await client.get('/');

      expect(response, expected);
    });

    group('.get()', () {
      test('returns the expected response', () async {
        final expected = '{"id": "1"}';
        final client = HttpClient(
          client: mockedClientWithResponse(expected),
        );
        final result = await client.get('one');

        expect(result, expected);
      });

      test('throws HttpException when statusCode is not 200', () async {
        final response = '{}';
        final client = HttpClient(
          client: mockedClientWithResponse(response, 500),
        );

        try {
          await client.get('one');
          assert(false);
        } catch (exception) {
          expect(exception, isA<HttpException>());
          expect(exception.response.body, response.toString());
        }
      });
    });
  });
}
