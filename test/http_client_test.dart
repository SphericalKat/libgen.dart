import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:libgen/src/exceptions.dart';
import 'package:libgen/src/http_client.dart';
import 'package:test/test.dart';

HttpClient _mockedClientWithRespoonse(response, [statusCode = 200]) =>
    HttpClient(
      client: MockClient(
          (request) async => Response(json.encode(response), statusCode)),
    );

void main() {
  group('HttpClient', () {
    test('provides a default [client]', () async {
      final client = HttpClient();
      final uri = Uri(scheme: 'https', host: 'example.com');
      final request = await client.send(Request('get', uri));

      expect(request is StreamedResponse, isTrue);
    });

    test('accepts a [client]', () async {
      final _client = _mockedClientWithRespoonse('', 200);
      final client = HttpClient(client: _client);
      final request = await client.send(Request('get', Uri()));

      expect(request is StreamedResponse, isTrue);
    });

    group('.request', () {
      test('returns the expected response', () async {
        final response = {'id': '1'};
        final client = _mockedClientWithRespoonse(response);
        final result = await client.request('one');

        expect(result, response);
      });

      test('throws HttpException when statusCode is not 200', () async {
        final response = {};
        final client = _mockedClientWithRespoonse(response, 500);

        try {
          await client.request('one');
          assert(false);
        } catch (exception) {
          expect(exception is HttpException, isTrue);
          expect(exception.response.body, response.toString());
        }
      });
    });
  });
}
