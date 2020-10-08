import 'dart:math';

const _pageSizes = [25, 50, 100];

/// The point of this class is to calculate the optimal [page] and [limit]
/// needed for the Libgen API.
/// Could be improved, but at the moment it's the best solution I can think of.
class Pagination {
  final int total;

  /// initial offset
  final int _initOffset;

  /// current useful results count
  int _count;

  /// sum of [_count]
  int _countSum = 0;

  /// current offset
  int _offset;

  /// current page number
  int _page = 1;

  /// current page limit
  int _limit;

  /// sum of [_limit]
  int _sink = 0;

  /// Required [total] number of items and optionally accepts an [offset].
  Pagination(this.total, {int offset = 0}) : _initOffset = offset {
    _computeFirstPage();
  }

  /// True if there are more pages to fetch
  bool get hasNext => _sink < total + _initOffset;

  /// The page size for Ligen API
  int get limit => _limit;

  /// The page number for Libgen API
  int get page => _page;

  /// The number of items the client should ignore at the start of the [List]
  int get ignoreFirst => _offset;

  /// The number of items the client should ignore at the end of the [List]
  int get ignoreLast => _limit - _count - _offset;

  /// calculates values for the next page
  void next() {
    assert(hasNext);

    _offset = 0;
    _page++;
    _count = min(_pageSizes.last, total - _countSum);
    _countWasUpdated();
  }

  void _computeFirstPage() {
    _offset = _initOffset;
    _count = min(_pageSizes.last, total - _countSum);

    if (_offset >= _pageSizes.first) {
      while (_offset > 0) {
        final localLimit = _computeLimit(_offset, true);
        if (_offset - localLimit < 0) {
          break;
        }
        _offset -= localLimit;
        _page++;
        _sink += localLimit;
      }
      if (total > _pageSizes.first) {
        _count -= _offset;
      }
    }

    _countWasUpdated();
  }

  void _countWasUpdated() {
    _countSum += _count;
    _limit = _computeLimit(_count);
    _sink += _limit;
  }
}

int _computeLimit(int count, [bool lower = false]) {
  if (count > _pageSizes.last) {
    return _pageSizes.last;
  }

  for (var idx = 0; idx < _pageSizes.length - 1; idx++) {
    final item = _pageSizes[idx];
    final div = count / item;

    if (div <= 1) {
      if (lower && idx > 0 && div != 1) {
        return _pageSizes[idx - 1];
      }

      return item;
    }
  }

  return _pageSizes.last;
}
