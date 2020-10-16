import 'package:meta/meta.dart';

import '../constants.dart';
import '../list_extension.dart';
import '../page_parser.dart';
import '../util.dart';
import 'compute_pagination.dart';
import 'page_options.dart';

typedef SearchRequest = Future<PageParser> Function(Map<String, String>);

@immutable
class LibgenSearch {
  final String query;
  final int count;
  final int offset;
  final SearchColumn searchIn;
  final List<PageOptions> _pages;

  LibgenSearch({
    @required this.query,
    this.count = 25,
    this.offset = 0,
    this.searchIn = SearchColumn.def,
  }) : _pages = computePagination(count, offset: offset);

  Map<String, String> get _defaultParams => {
        'req': query,
        'column': enumValue(searchIn),
        'view': 'simple',
      };

  Future<List<int>> run(SearchRequest search) async {
    final idsAcc = <int>[];

    for (final page in _pages) {
      final query = {
        'page': page.page,
        'res': page.limit,
      }..addAll(_defaultParams);
      final data = await search(query);
      final ids = data.ids.drop(page.ignoreFirst, page.ignoreLast);

      idsAcc.addAll(ids);
    }

    return idsAcc;
  }
}
