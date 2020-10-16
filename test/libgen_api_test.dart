import 'package:libgen/src/libgen_api.dart';
import 'package:libgen/src/page_parser.dart';
import 'package:test/test.dart';

import '__mocks__/client_mock.dart';

void main() {
  group('LibgenApi', () {
    group('.getByIds()', () {
      test('returns the expected List', () async {
        final response = [];
        final client = mockedClientWithResponse(response.toString());
        final api = LibgenApi(client: client);

        expect(await api.getByIds([1]), response);
      });

      test('returns Null when client replies with Null', () async {
        final client = mockedClientWithResponse(null);
        final api = LibgenApi(client: client);

        expect(await api.getByIds([1]), null);
      });
    });

    group('.search()', () {
      test('returns the expected String', () async {
        final response = '<div>pong</div>';
        final expected = PageParser(response);
        final client = mockedClientWithResponse(response.toString());
        final api = LibgenApi(client: client);

        expect(await api.search({}), expected);
      });
    });
  });
}
