import 'package:meta/meta.dart';

class MirrorSchema {
  final bool canDownload;
  final String scheme;
  final String host;

  const MirrorSchema({
    @required this.host,
    this.scheme = 'http',
    this.canDownload = false,
  });
}
