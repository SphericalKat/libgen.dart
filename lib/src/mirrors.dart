import 'package:libgen/src/mirror_schema.dart';

final libgenMirrorSchemas = [
  LibgenMirrorSchema(
    host: 'libgen.is',
    canDownload: true,
  ),
  LibgenMirrorSchema(
    host: 'gen.lib.rus.ec',
  ),
];

final defaultMirror = libgenMirrorSchemas.first;
