import 'mirror.dart';
import 'mirror_finder.dart';
import 'mirrors.dart';

class Libgen {
  LibgenMirror _mirror;

  Libgen({LibgenMirror mirror}) {
    _mirror ??= LibgenMirror.fromSchema(defaultMirror);
  }

  /// Calls each [LibgenMirror] ping() method and sets the one
  /// which has the shortest response
  Future setFastestMirror() async {
    _mirror = await MirrorFinder().fastest();
  }

  /// Sets [_mirror] to the first [LibgenMirror] which has a successful response
  Future setAnyMirror() async {
    _mirror = await MirrorFinder().any();
  }

  Future<List> getByIds(List<int> ids, [String fields = '*']) =>
      _mirror.getByIds(ids, fields);
}
