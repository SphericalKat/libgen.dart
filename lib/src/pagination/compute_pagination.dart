import 'pagination.dart';
import 'pagination_options.dart';

/// The point of this function is to calculate the optimal pages and their sizes
/// Could be improved, but at the moment it's the best solution I can think of.
List<PageData> computePagination(int total, {int offset = 0}) {
  final list = <PageData>[];
  final nav = Pagination(total, offset: offset);

  PageData collect() => PageData(
        limit: nav.limit,
        page: nav.page,
        ignoreLast: nav.ignoreLast,
        ignoreFirst: nav.ignoreFirst,
        hasNext: nav.hasNext,
      );

  list.add(collect());
  while (nav.hasNext) {
    nav.next();
    list.add(collect());
  }

  return list;
}
