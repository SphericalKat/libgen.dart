import 'package:libgen/libgen.dart';
import 'package:libgen/src/models/book.dart';
import 'package:libgen/src/models/search.dart';
import 'package:libgen/src/util.dart';

void printList(List<Book> list) => list.forEach((item) => print(beautify(pick(
      item.toJson(),
      ['id', 'title', 'author', 'md5'],
    ))));

void main() async {
  final libgen = await Libgen.any();

  // print(await libgen.getById(1591104));
  // print(await libgen.getById(1));
  // print(await libgen.getByIds([1, 2]));
  // print(await libgen.getLatestId());
  // print(await libgen.getLatestMd5());
  // print(await libgen.getLatest());
  print('here');
  printList(await libgen.search(
    text: 'dark matter',
    count: 10,
    searchIn: SearchColumn.title,
  ));
  print('here2');
}
