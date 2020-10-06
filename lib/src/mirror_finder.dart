import 'exceptions.dart';
import 'libgen.dart';
import 'mirror_schema.dart';
import 'util.dart';

class MirrorFinder {
  final Iterable<Libgen> _mirrors;

  /// Accepts an [Iterable] of [Libgen]
  MirrorFinder(Iterable<Libgen> mirrors) : _mirrors = mirrors;

  /// Sets [_mirrors] to [schemas] mapped to [Libgen]
  MirrorFinder.fromSchemas(Iterable<MirrorSchema> schemas)
      : _mirrors = schemas.map((schema) => Libgen.fromSchema(schema));

  /// Returns the [Duration] that took to call [mirror.ping]
  Future<Duration> test(Libgen mirror) async {
    try {
      final stopwatch = Stopwatch()..start();

      await mirror.ping();

      return stopwatch.elapsed;
    } catch (e) {
      return null;
    }
  }

  /// Returns the [Libgen] with the fastest response on [Libgen.ping].
  /// Throws an [Exception] when all fail.
  Future<Libgen> fastest() async {
    final futures = _mirrors.map(test);
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx != null) {
      return _mirrors.elementAt(fastestIdx);
    }

    throw NoAvailableMirrorException();
  }

  /// Returns the first [Libgen] that has a successful reply on [Libgen.ping].
  /// Throws an [Exception] when all fail.
  Future<Libgen> any() async {
    for (final mirror in _mirrors) {
      if (await test(mirror) != null) {
        return mirror;
      }
    }

    throw NoAvailableMirrorException();
  }
}
