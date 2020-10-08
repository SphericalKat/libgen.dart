import 'package:libgen/src/pagination/compute_pagination.dart';
import 'package:libgen/src/pagination/pagination_options.dart';
import 'package:test/test.dart';

void main() {
  group('computePagination', () {
    group('single page', () {
      test('full without offset', () {
        final nav = computePagination(25);

        expect(nav, [
          PageData(
            limit: 25,
            page: 1,
            ignoreFirst: 0,
            ignoreLast: 0,
            hasNext: false,
          )
        ]);
      });

      test('partial page with offset', () {
        final nav = computePagination(30, offset: 5);

        expect(nav, [
          PageData(
            limit: 50,
            page: 1,
            ignoreFirst: 5,
            ignoreLast: 15,
            hasNext: false,
          )
        ]);
      });
    });

    group('multiple pages', () {
      test('2 without offset', () {
        final nav = computePagination(120);

        expect(nav, [
          PageData(
            limit: 100,
            page: 1,
            ignoreFirst: 0,
            ignoreLast: 0,
            hasNext: true,
          ),
          PageData(
            limit: 25,
            page: 2,
            ignoreFirst: 0,
            ignoreLast: 5,
            hasNext: false,
          ),
        ]);
      });
      test('2 with offset', () {
        final nav = computePagination(120, offset: 70);

        expect(nav, [
          PageData(
            limit: 100,
            page: 2,
            ignoreLast: 0,
            ignoreFirst: 20,
            hasNext: true,
          ),
          PageData(
            limit: 50,
            page: 3,
            ignoreLast: 10,
            ignoreFirst: 0,
            hasNext: false,
          ),
        ]);
      });
    });
  });
}
