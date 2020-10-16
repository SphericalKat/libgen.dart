import 'package:libgen/src/search/libgen_search.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../__mocks__/book_mock.dart';
import '../__mocks__/libgen_api_mock.dart';
import '../__mocks__/pages_mock.dart';

void main() {
  group('LibgenSearch', () {
    group('.run()', () {
      test('returns the expected ids', () async {
        final query = 'something';
        final expected = [darkMatterBook.object];
        final ids = expected.map((e) => e.id).toList();
        final api = mockedLibgenApi();
        when(api.search(any)).thenAnswer((_) async => parsedPageWithIds(ids));

        final libgenSearch = LibgenSearch(query: query, count: 25);
        final result = await libgenSearch.run(api.search);

        verify(api.search({
          'req': query,
          'res': '25',
          'page': '1',
          'column': 'def',
          'view': 'simple',
        }));

        expect(result, ids);
      });
    });
  });
}
