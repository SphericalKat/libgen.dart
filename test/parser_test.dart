import 'package:libgen/src/parser.dart';
import 'package:test/test.dart';

import '__mocks__/pages_mock.dart';

void main() {
  group('LibgenPageParser', () {
    test('returns the expected index', () async {
      final html = await searchPage;
      final parser = LibgenPageParser(html);

      expect(
          parser.ids,
          equals([
            2761887,
            2761886,
            2761885,
            2761884,
            2761883,
            2761882,
            2761881,
            2761880,
            2761879,
            2761878,
            2761877,
            2761876,
            2761875,
            2761874,
            2761873,
            2761872,
            2761871,
            2761870,
            2761869,
            2761868,
            2761867,
            2761866,
            2761865,
            2761864,
            2761863
          ]));
    });
    test('returns the expected .firstId', () async {
      final html = await searchPage;
      final parser = LibgenPageParser(html);

      expect(parser.firstId, equals(2761887));
    });
  });
}
