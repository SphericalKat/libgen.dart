import 'package:libgen/libgen.dart';
import 'package:libgen/src/models/book.dart';
import 'package:libgen/src/models/search.dart';
import 'package:libgen/src/util.dart';

Map<K, V> pick<K, V>(Map<K, V> json, List<K> keys) =>
    Map<K, V>.fromEntries(keys.map((key) => MapEntry(key, json[key])));

void printList(List<Book> list) => list.forEach((item) => print(beautify(pick(
      item.toJson(),
      ['id', 'title', 'author', 'md5'],
    ))));

void main() async {
  final libgen = Libgen();

  // print(await libgen.getById(1591104));
  // print(await libgen.getById(1));
  // print(await libgen.getByIds([1, 2]));
  // print(await libgen.getLatestId());
  // print(await libgen.getLatestMd5());
  // print(await libgen.getLatest());
  printList(await libgen.search(
    query: 'dark matter',
    count: 2,
    searchIn: SearchColumn.title,
  ));
}
