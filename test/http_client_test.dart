import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:libgen/src/http_client.dart';
import 'package:test/test.dart';

void main() {
  group('HttpClient', () {
    final mockedClient = (response, [statusCode = 200]) => HttpClient(
          client: MockClient(
              (request) async => Response(json.encode(response), statusCode)),
        );

    test('provides a default `client`', () async {
      final client = HttpClient();
      final uri = Uri(scheme: 'https', host: 'example.com');
      final request = await client.send(http.Request('get', uri));

      expect(request is http.StreamedResponse, equals(true));
    });

    test('accepts a `client`', () async {
      final _client = MockClient((request) async => Response('', 200));
      final client = HttpClient(client: _client);
      final request = await client.send(http.Request('get', Uri()));

      expect(request is http.StreamedResponse, equals(true));
    });

    group('request', () {
      test('returns the expected response', () async {
        final response = {'id': '1'};
        final client = mockedClient(response);
        final result = await client.request('one');

        expect(result, equals(response));
      });

      test('returns the expected response', () async {
        final response = {};
        final client = mockedClient(response, 500);
        final result = await client.request('one').catchError((error) {
          expect(error.body, equals(response.toString()));
        });
        expect(result, equals(null));
      });
    });
  });
}
