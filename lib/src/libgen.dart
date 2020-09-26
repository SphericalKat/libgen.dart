import 'mirror.dart';
import 'mirror_finder.dart';
import 'mirrors.dart';

class Libgen {
  LibgenMirror mirror;

  Libgen({this.mirror}) {
    mirror ??= LibgenMirror.fromSchema(defaultMirror);
  }

  void setFastestMirror() async {
    final fastest = await LibgenMirrorFinder(mirrors).fastest();

    mirror = LibgenMirror.fromSchema(fastest);
  }

  static final mirrors = libgenMirrorSchemas;
}
