import 'package:html/dom.dart';
import 'package:html/parser.dart';

class LibgenPageParser {
  final Document _document;

  LibgenPageParser(String html) : _document = parse(html);

  List<int> get ids => _rows.map<int>(_extractRowId).toList(growable: false);

  int get firstId => _extractRowId(_rows.first);

  List get _rows => _document.querySelectorAll('.c tr')..removeAt(0);

  int _extractRowId(el) => int.parse(el.querySelector('td').text);
}
