import 'package:meta/meta.dart';

@immutable
class MirrorSchema {
  final Uri baseUri;
  final MirrorOptions options;

  const MirrorSchema({
    @required this.baseUri,
    this.options = const MirrorOptions(),
  });
}

@immutable
class MirrorOptions {
  final bool canDownload;

  const MirrorOptions({
    this.canDownload = false,
  });
}
