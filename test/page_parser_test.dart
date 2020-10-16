import 'package:libgen/src/page_parser.dart';
import 'package:test/test.dart';

import '__mocks__/pages_mock.dart';
import 'constants.dart';

void main() async {
  final html = await getSearchPage();
  group('LibgenPageParser', () {
    test('returns the expected list of ids from a fetched page', () {
      final parser = PageParser(html);

      expect(parser.ids, [
        62088,
        162642,
        254180,
        254300,
        257758,
        258369,
        273947,
        262824,
        262826,
        264371,
        264495,
        269781,
        343251,
        357371,
        387719,
        389057,
        389425,
        391527,
        391961,
        396417,
        406729,
        416043,
        422491,
        429205,
        430596
      ]);
    });

    group('.ids', () {
      test('returns the expected list from HTML String', () {
        final ids = [1, 2, 3];
        final parser = PageParser(getHtmlPageWithIds(ids));

        expect(parser.ids, ids);
      });

      test('returns an empty list when has an invalid HTML', () {
        final parser = PageParser('invalid');

        expect(parser.ids, []);
      });
    });

    group('.firstId', () {
      test('returns the expected value', () {
        final parser = PageParser(getHtmlPageWithIds([1]));

        expect(parser.firstId, 1);
      });

      test('returns null when the ids List is empty', () {
        final parser = PageParser(getHtmlPageWithIds([]));

        expect(parser.firstId, null);
      });

      test('returns null when [html] is invalid', () {
        final parser = PageParser('invalid');

        expect(parser.firstId, null);
      });
    });

    test('== returns the expected result', () {
      final ids = [1, 2, 3];
      final response = getHtmlPageWithIds(ids);

      expect(PageParser(response), PageParser(response));
      expect(PageParser(response), isNot(PageParser('response')));
    });
  }, tags: HTTP);
}
