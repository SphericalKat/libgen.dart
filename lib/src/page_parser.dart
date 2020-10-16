import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'list_extension.dart';

class PageParser {
  final String html;
  final Document _document;

  PageParser(this.html) : _document = parse(html);

  List<int> get ids => _rows.map<int>(_extractRowId).toList(growable: false);

  int get firstId => _extractRowId(_rows.firstOrNull);

  List<Element> get _rows {
    final list = _document.querySelectorAll('.c tr');

    if (list.isNotEmpty) {
      list.removeAt(0);
    }

    return list;
  }

  int _extractRowId(el) {
    final text = el?.querySelector('td')?.text;

    return text == null ? null : int.parse(text);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageParser &&
          runtimeType == other.runtimeType &&
          html == other.html;
}
