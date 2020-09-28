import 'package:libgen/libgen.dart';

void main() async {
  final libgen = await Libgen.any();

  final result = await libgen.getById('1591104');
  print(result);
}
