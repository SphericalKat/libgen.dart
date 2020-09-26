import 'package:meta/meta.dart';

class LibgenMirrorSchema {
  final bool canDownload;
  final String scheme;
  final String host;

  LibgenMirrorSchema({
    this.scheme = 'http',
    @required this.host,
    this.canDownload = false,
  }) {
    assert(host != null);
  }
}
