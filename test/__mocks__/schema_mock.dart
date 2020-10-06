import 'package:libgen/src/mirror_schema.dart';

final workingSchemaSample = MirrorSchema(
  baseUri: Uri.http('libgen.is', ''),
);

final brokenSchemaSample = MirrorSchema(
  baseUri: Uri.http('a.b.co', ''),
);
