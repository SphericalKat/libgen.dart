import 'models/book.dart';

String get searchFields => Book(id: 0, md5: '').toJson().keys.join(',');

enum SearchColumn {
  def,
  title,
  author,
  series,
  periodical,
  publisher,
  year,
  identifier,
  md5,
  extension,
}
