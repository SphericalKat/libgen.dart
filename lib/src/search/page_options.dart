class PageOptions {
  /// The page size for Ligen API
  final String limit;

  /// The page number for Libgen API
  final String page;

  /// The number of items the client should ignore at the end of the [List]
  final int ignoreLast;

  /// The number of items the client should ignore at the start of the [List]
  final int ignoreFirst;

  /// True if there are more pages to fetch
  final bool hasNext;

  PageOptions({
    int page,
    int limit,
    this.ignoreLast,
    this.ignoreFirst,
    this.hasNext,
  })  : page = page.toString(),
        limit = limit.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageOptions &&
          runtimeType == other.runtimeType &&
          limit == other.limit &&
          page == other.page &&
          ignoreLast == other.ignoreLast &&
          ignoreFirst == other.ignoreFirst &&
          hasNext == other.hasNext;
}
