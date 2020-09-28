import 'mirror_schema.dart';

final List<MirrorSchema> mirrorSchemas = [
  MirrorSchema(
    baseUri: Uri.http('libgen.is', ''),
    options: MirrorOptions(canDownload: true),
  ),
  MirrorSchema(
    baseUri: Uri.http('gen.lib.rus.ec', ''),
  ),
];
