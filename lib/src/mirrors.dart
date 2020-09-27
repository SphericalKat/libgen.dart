import 'mirror_schema.dart';

const List<MirrorSchema> libgenMirrorSchemas = [
  MirrorSchema(
    host: 'libgen.is',
    canDownload: true,
  ),
  MirrorSchema(
    host: 'gen.lib.rus.ec',
  ),
];

final defaultMirror = libgenMirrorSchemas.first;
