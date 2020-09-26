import 'package:libgen/libgen.dart';

void main() async {
  final libgen = Libgen();
  await libgen.setFastestMirror();

  final result = await libgen.mirror.getByIds([1]);
  print(result);
}
