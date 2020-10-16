import 'package:meta/meta.dart';

import '../list_extension.dart';
import '../page_parser.dart';
import 'compute_pagination.dart';
import 'page_options.dart';

typedef SearchRequest = Future<PageParser> Function(Map<String, String>);

@immutable
class LibgenSearch {
  final String query;
  final int count;
  final int offset;
  final String searchIn;
  final List<PageOptions> _nav;

  LibgenSearch({
    @required this.query,
    this.count,
    this.offset,
    this.searchIn,
  }) : _nav = computePagination(count, offset: offset);

  Map<String, String> get defaultParams => {
        'req': query,
        'column': searchIn,
        'view': 'simple',
      };

  Future<List<int>> run(SearchRequest search) async {
    final idsAcc = <int>[];

    for (final page in _nav) {
      final query = {
        'page': page.page,
        'res': page.limit,
      }..addAll(defaultParams);
      final data = await search(query);
      final ids = data.ids.drop(page.ignoreFirst, page.ignoreLast);

      idsAcc.addAll(ids);
    }

    return idsAcc;
  }
}
