import 'package:libgen/src/exceptions.dart';
import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirrors.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import '__mocks__/schema_mock.dart';
import 'constants.dart';

// ignore: must_be_immutable
class MockLibgen extends Mock implements Libgen {}

void main() {
  group('MirrorFinder', () {
    final workingMirror = MockLibgen();
    final brokenMirror = MockLibgen();
    final list = [workingMirror, brokenMirror];
    final _reset = () {
      reset(workingMirror);
      reset(brokenMirror);

      when(workingMirror.ping())
          .thenAnswer((_) async => darkMatterBook.toString());

      when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());
    };

    group('.fromSchemas()', () {
      test('returns a [MirrorFinder] instance from mocked schemas', () {
        expect(MirrorFinder.fromSchemas([workingSchemaSample]) is MirrorFinder,
            isTrue);
        expect(MirrorFinder.fromSchemas([]) is MirrorFinder, isTrue);
      });

      test('returns a [MirrorFinder] instance from real schemas', () {
        expect(MirrorFinder.fromSchemas(mirrorSchemas) is MirrorFinder, isTrue);
      }, tags: HTTP);
    });

    group('.fastest()', () {
      final finder = MirrorFinder(list);
      setUp(_reset);

      test('returns the expected [Libgen] instance', () async {
        expect(await finder.fastest(), workingMirror);
      });

      test('throws an [Exception] when all mirrros throw', () async {
        when(workingMirror.ping()).thenAnswer((_) async => throw Exception());

        try {
          await finder.fastest();
          assert(false);
        } catch (e) {
          expect(e is NoAvailableMirrorException, isTrue);
        }
      });
    });

    group('.any()', () {
      final finder = MirrorFinder(list);
      setUp(_reset);

      test('returns the expected [Libgen] instance', () async {
        expect(await finder.any(), workingMirror);
      });

      test('does not call the other mirror once it finds one', () async {
        expect(await finder.any(), workingMirror);

        verifyZeroInteractions(brokenMirror);
      });

      test('throws an [Exception] when all mirrros throw', () async {
        when(workingMirror.ping()).thenAnswer((_) async => throw Exception());

        try {
          await finder.any();
          assert(false);
        } catch (e) {
          expect(e is NoAvailableMirrorException, isTrue);
        }
      });
    });
  });
}
