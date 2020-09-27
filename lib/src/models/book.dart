import 'package:meta/meta.dart';

import '../util.dart';

@immutable
class Book {
  final String id;
  final String md5;
  final String title;
  final String author;
  final String year;
  final String edition;
  final String publisher;
  final String descr;
  final String identifier;
  final String ext;

  Book({
    @required this.id,
    @required this.md5,
    this.title,
    this.author,
    this.year,
    this.edition,
    this.publisher,
    this.descr,
    this.identifier,
    this.ext,
  })  : assert(id != null, 'id is required'),
        assert(md5 != null, 'md5 is required');

  Book.fromJson(Map json)
      : id = json['id'],
        md5 = json['md5'],
        title = json['title'],
        author = json['author'],
        year = json['year'],
        edition = json['edition'],
        publisher = json['publisher'],
        descr = json['descr'],
        identifier = json['identifier'],
        ext = json['extension'];

  Map<String, String> toJson() => {
        'id': id,
        'md5': md5,
        'title': title,
        'author': author,
        'year': year,
        'edition': edition,
        'publisher': publisher,
        'descr': descr,
        'identifier': identifier,
        'extension': ext,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          md5 == other.md5 &&
          title == other.title &&
          author == other.author &&
          year == other.year &&
          edition == other.edition &&
          publisher == other.publisher &&
          descr == other.descr &&
          identifier == other.identifier &&
          ext == other.ext;

  @override
  int get hashCode => md5.hashCode;

  @override
  String toString() => '$runtimeType ${beautify(toJson())}';
}
