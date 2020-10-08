import 'package:libgen/src/pagination/pagination.dart';
import 'package:test/test.dart';

void main() {
  group('Pagination', () {
    group('single page', () {
      test('full without offset', () {
        final pagination = Pagination(25);

        expect(pagination.limit, 25);
        expect(pagination.page, 1);
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.ignoreLast, isZero);
        expect(pagination.hasNext, isFalse);
      });

      test('full second page', () {
        final pagination = Pagination(25, offset: 25);

        expect(pagination.limit, 25);
        expect(pagination.page, 2);
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.ignoreLast, isZero);
        expect(pagination.hasNext, isFalse);
      });

      test('partial fifth page', () {
        final pagination = Pagination(5, offset: 501);

        expect(pagination.limit, 25);
        expect(pagination.page, 6);
        expect(pagination.ignoreFirst, 1);
        expect(pagination.ignoreLast, 19);
        expect(pagination.hasNext, isFalse);
      });

      test('partial page without offset', () {
        final pagination = Pagination(10);

        expect(pagination.limit, 25);
        expect(pagination.page, 1);
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.ignoreLast, 15);
        expect(pagination.hasNext, isFalse);
      });

      test('partial small page with offset', () {
        final pagination = Pagination(10, offset: 5);

        expect(pagination.limit, 25);
        expect(pagination.page, 1);
        expect(pagination.ignoreFirst, 5);
        expect(pagination.ignoreLast, 10);
        expect(pagination.hasNext, isFalse);
      });

      test('partial medium page with offset', () {
        final pagination = Pagination(30, offset: 5);

        expect(pagination.limit, 50);
        expect(pagination.page, 1);
        expect(pagination.ignoreFirst, 5);
        expect(pagination.ignoreLast, 15);
        expect(pagination.hasNext, isFalse);
      });

      test('partial second page with offset greater than min page size', () {
        final pagination = Pagination(5, offset: 30);

        expect(pagination.limit, 25);
        expect(pagination.page, 2);
        expect(pagination.ignoreFirst, 5);
        expect(pagination.ignoreLast, 15);
        expect(pagination.hasNext, isFalse);
      });

      test('partial second page with offset greater than max page size', () {
        final pagination = Pagination(5, offset: 100);

        expect(pagination.limit, 25);
        expect(pagination.page, 2);
        expect(pagination.ignoreFirst, 0);
        expect(pagination.ignoreLast, 20);
        expect(pagination.hasNext, isFalse);
      });
    });

    group('multiple pages', () {
      test('2 without offset', () {
        final pagination = Pagination(120);

        expect(pagination.limit, 100);
        expect(pagination.page, 1);
        expect(pagination.ignoreFirst, 0);
        expect(pagination.ignoreLast, 0);
        expect(pagination.hasNext, isTrue);

        pagination.next();

        expect(pagination.limit, 25);
        expect(pagination.page, 2);
        expect(pagination.ignoreFirst, 0);
        expect(pagination.ignoreLast, 5);
        expect(pagination.hasNext, isFalse);
      });

      test('2 with offset', () {
        final pagination = Pagination(120, offset: 30);

        expect(pagination.limit, 100);
        expect(pagination.page, 2);
        expect(pagination.ignoreFirst, 5);
        expect(pagination.ignoreLast, 0);
        expect(pagination.hasNext, isTrue);

        pagination.next();

        expect(pagination.limit, 25);
        expect(pagination.page, 3);
        expect(pagination.ignoreFirst, 0);
        expect(pagination.ignoreLast, 0);
        expect(pagination.hasNext, isFalse);
      });

      test('3 with offset', () {
        final pagination = Pagination(201, offset: 301);

        expect(pagination.limit, 100);
        expect(pagination.page, 4);
        expect(pagination.ignoreFirst, 1);
        expect(pagination.ignoreLast, 0);
        expect(pagination.hasNext, isTrue);

        pagination.next();

        expect(pagination.limit, 100);
        expect(pagination.page, 5);
        expect(pagination.ignoreFirst, 0);
        expect(pagination.ignoreLast, 0);
        expect(pagination.hasNext, isTrue);

        pagination.next();

        expect(pagination.limit, 25);
        expect(pagination.page, 6);
        expect(pagination.ignoreFirst, 0);
        expect(pagination.ignoreLast, 23);
        expect(pagination.hasNext, isFalse);
      });
    });
  });
}
