import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/util.dart';

class LibgenMirrorFinder {
  final List<LibgenMirrorSchema> mirrors;

  LibgenMirrorFinder(this.mirrors);

  /// Calls [LibgenMirror] ping() method and
  /// returns the [Duration] that took to do this
  Future<Duration> _test(LibgenMirrorSchema mirror) async {
    try {
      final stopwatch = Stopwatch()..start();

      await LibgenMirror.fromSchema(mirror).ping();

      return stopwatch.elapsed;
    } catch (e) {
      return null;
    }
  }

  /// Calls every [LibgenMirror] ping() method and
  /// returns the [LibgenMirror] which replied the fastest
  Future<LibgenMirrorSchema> fastest() async {
    if (mirrors.length == 1) {
      return mirrors.first;
    }

    final futures = mirrors.map((mirror) => _test(mirror));
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx == null) {
      throw Exception('No working mirror');
    }

    return mirrors[fastestIdx];
  }
}
